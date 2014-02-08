#!/bin/sh
# All your benchmarks should be in Assignment-1B/ directory, which is the current directory.
#
#
for f in *.c
do
    echo "Compiling $f with Optimizations disabled"
    NAME=$(basename $f .c) 
    gcc -O0 -o "$NAME.out" $f
done

mkdir -p output
#--Compilation done.
fullPath="/home/dual/cs5100277/Documents/tejas/Assignment-1B/"
jarFile="/home/atul/Documents/tejas/Tejas/jars/tejas.jar"
output="/home/dual/cs5100277/Documents/tejas/Assignment-1B/output/"
configFile="//home/atul/Documents/tejas/Tejas/src/simulator/config/config.xml"
declare -a predictor=(Bimodal GAg GAp PAg PAp)
declare -a pcbit=(2 4 8 16 32)
declare -a bhrsize=(2 4 8 16 32)
declare -a saturatingBits=(1 2 4)
for f in *.c
do                                                                  
    echo "Running $f"

    # Change config file.
    for p in ${predictor[@]}
    do
        echo "Running for branch predictor $p"
        sed -i "62s/.*/<Predictor_Mode>$p<\/Predictor_Mode>/" $configFile 
        # Running for different pcbit
        for pc in ${pcbit[@]}
        do
            echo "PCbit: $pc"
            sed -i "63s/.*/<PCBits>$pc<\/PCBits>/" $configFile
            #Running for different bhrbit
            for bhr in ${bhrsize[@]}
            do
                echo "bhrsize: $bhr"

                sed -i "64s/.*/<BHRsize>$bhr<\/BHRsize>/" $configFile
                for sat in ${saturatingBits[@]}
                do

                    echo "saturatingBits: $sat"
                    sed -i "66s/.*/<SaturatingBits>$sat<\/SaturatingBits>/" $configFile

                    #changing config file 
                    echo "Config file changed with $p $pc $bhr $sat"


                    outputFile="$p.$pc.$bhr.$sat.awesome"
                    EXEC=$(basename $f .c)
                    echo "Output to $outputFile"
                    java -jar $jarFile $configFile "$output/$outputFile" "$fullPath/$EXEC.out"
                    echo "Saved output to $outputFile"
                    echo "----------------------------------------------------"
                done
            done

        done                   
    done               
    echo "--------------------------------------------------------------"
    echo "x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
done
