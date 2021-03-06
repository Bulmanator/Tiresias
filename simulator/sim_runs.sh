#!/bin/bash
placement=("yarn") 
#schedule=("fifo" "fjf" "sjf" "shortest" "shortest-gpu" "dlas" "dlas-gpu")
#schedule=("dlas" "dlas-gpu" "dlas-gpu-100" "dlas-gpu-8" "dlas-gpu-4" "dlas-gpu-2" "dlas-gpu-1" "dlas-gpu-05")
# schedule=("dlas-gpu")
schedule=("gandiva")
#schedule=("shortest-gpu")
#schedule=("dlas" "dlas-gpu")
# schedule=("dlas-gpu-05")
# schedule=("dlas-gpu-1" "dlas-gpu-2" "dlas-gpu-4" "dlas-gpu-8" "dlas-gpu-10" "dlas-gpu-100" "dlas-gpu-1000")
#schedule=("fifo")
jobs=("60")
setups=("n4g4")


for setup in ${setups[@]};do
    cluster_spec="${setup}.csv"
    for job in ${jobs[@]};do
        job_file="${job}_job.csv"
        log_folder="${setup}_j${job}"
        for p in ${placement[@]};do
            for s in ${schedule[@]};do
                log_name="${log_folder}/${s}-${p}"
                cmd="python3 run_sim.py --cluster_spec=${cluster_spec} --scheme=${p} --trace_file=${job_file} --schedule=${s} --log_path=${log_name}"
                echo ${cmd} 
                python3 run_sim.py --cluster_spec=${cluster_spec} --scheme=${p} --trace_file=${job_file} --schedule=${s} --log_path=${log_name}
            done
        done
    done
done
