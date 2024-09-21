#!/usr/bin/gawk -f

BEGIN {
    FS = ","
    max_timing = 0
    p1_head=1
    p2_head=1
    p3_head=1

    p1_end=0
    p2_end=0
    p3_end=0
}

{
    priority[$1] = int($2)
    event[int($3), 1]++;
    event[int($3), event[int($3), 1]+1, 1] = $1
    event[int($3), event[int($3), 1]+1, 2] = 0

    if (int($3) > max_timing) max_timing = int($3)

    cpu_running[$1] = 0
    io_running[$1] = 0
    for (i=4; i<NF; i++) {
        cpu[$1, (i-2)/2] = int($i)
        io[$1, (i-3)] = int($i)
    }

    if (NF > 3) cpu[(NF-2)/2] = int($NF);
}

END {  

    printf("") >> "temp.txt"
    printf("") >> "status.txt"

    cpu_status = "";
    start_time = 0;
    cpu_start = 0;
    current_event = ""
    while (start_time < max_timing) {
        start_time++;
        if (event[start_time, 1] == 0) continue;
        no_events = event[start_time, 1]

        printf("%s\n", cpu_status) >> "status.txt"
        if (cpu_status == "") {
            if (cpu_start == 0) printf("[%d -- %d] CPU idle\n", cpu_start, start_time) > "output_final.txt"
            else printf("[%d -- %d] CPU idle\n", cpu_start, start_time) >> "output_final.txt"
        }

        printf("%d %d\n", start_time, no_events)

        for (i=2; i<=(no_events+1); i++) {

            current_event = event[start_time, i, 1]
            if (event[start_time, i, 2] == 0) {
                printf("\t\t\t\t\t\t[%d] %s arrives\n", start_time, current_event) >> "output_final.txt"
                if (priority[current_event] == 1) {
                    p1_end++;
                    p1[p1_end] = current_event;
                } else if (priority[current_event] == 2) {
                    p2_end++;
                    p2[p2_end] = current_event;
                } else {
                    p3_end++;
                    p3[p3_end] = current_event;
                }
            } else if (event[start_time, i, 2] == 1) {
                printf("\t\t\t\t\t\t[%d] %s completes IO\n", start_time, current_event) >> "output_final.txt"
                if (priority[current_event] == 1) {
                    p1_end++;
                    p1[p1_end] = current_event;
                } else if (priority[current_event] == 2) {
                    p2_end++;
                    p2[p2_end] = current_event;
                } else {
                    p3_end++;
                    p3[p3_end] = current_event;
                }
            } else if (event[start_time, i, 2] == 2) {
                cpu_start = start_time
                printf("%d\n", length(io[$1]))
                if (io_running[$1] != length(io[$1])) {
                    printf("\t\t\t\t\t\t[%d] %s starts IO\n", start_time, current_event) >> "output_final.txt"
                    io_running[$1]++;
                    event[start_time+io[$1, io_running[$1]], 1]++
                    event[start_time+io[$1, io_running[$1]], event[start_time+io[$1, io_running[$1]], 1], 1] = current_event
                    event[start_time+io[$1, io_running[$1]], event[start_time+io[$1, io_running[$1]], 1], 2] = 1

                    if (max_timing < start_time+io[$1, io_running[$1]]) max_timing = start_time+io[$1, io_running[$1]]
                }
            }
        }

        printf("%d %d\n", cpu_start, start_time) >> "temp.txt"

        if (cpu_start == start_time || cpu_status == "") {
            printf("[At time %d]\n", start_time) >> "output_final.txt"
            printf("\tQ1: ") >> "output_final.txt"
            for (i = p1_head; i<= p1_end; i++) {
                printf("%s ", p1[i]) >> "output_final.txt"
            }
            printf("\n\tQ2: ") >> "output_final.txt"
            for (i = p2_head; i<= p2_end; i++) {
                printf("%s ", p2[i]) >> "output_final.txt"
            }
            printf("\n\tQ3: ") >> "output_final.txt"
            for (i = p3_head; i<= p3_end; i++) {
                printf("%s ", p3[i]) >> "output_final.txt"
            }
            printf("\n") >> "output_final.txt"
        }

        if (p1_head <= p1_end) {
            cpu_status = p1[p1_head];
            p1_head++
            cpu_running[cpu_status]++;
            cpu_start = start_time + cpu[cpu_status, cpu_running[cpu_status]]

            printf("[%d -- %d] CPU runs %s\n", start_time, cpu_start, cpu_status) >> "output_final.txt"
            if (max_timing < cpu_start) max_timing = cpu_start

            event[cpu_start, 1]++
            event[cpu_start, event[cpu_start, 1]+1, 1] = cpu_status
            event[cpu_start, event[cpu_start, 1]+1, 2] = 2
        } else if (p2_head <= p2_end) {
            cpu_status = p2[p2_head]
            p2_head++
            cpu_running[cpu_status]++;
            cpu_start = start_time + cpu[cpu_status, cpu_running[cpu_status]]
            printf("[%d -- %d] CPU runs %s\n", start_time, cpu_start, cpu_status) >> "output_final.txt"

            if (max_timing < cpu_start) max_timing = cpu_start

            event[cpu_start, 1]++
            event[cpu_start, event[cpu_start, 1]+1, 1] = cpu_status
            event[cpu_start, event[cpu_start, 1]+1, 2] = 2
        } else if (p3_head <= p3_end) {
            cpu_status = p3[p3_head]
            p3_head++;
            cpu_running[cpu_status]++;
            cpu_start = start_time + cpu[cpu_status, cpu_running[cpu_status]]
            printf("[%d -- %d] CPU runs %s\n", start_time, cpu_start, cpu_status) >> "output_final.txt"
            if (max_timing < cpu_start) max_timing = cpu_start

            event[cpu_start, 1]++
            event[cpu_start, event[cpu_start, 1]+1, 1] = cpu_status
            event[cpu_start, event[cpu_start, 1]+1, 2] = 2
        } else {
            cpu_start = start_time
            cpu_status = ""
        }

    }


}