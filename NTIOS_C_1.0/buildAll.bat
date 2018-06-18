@echo off
sdasz80 -lo boot.s
echo "assembled boot.s"
sdasz80 -lo crt0.s
echo "assembled crt0.s"
sdcc main.c --std-sdcc99 -mz80 -c -o main/ --no-std-crt0 --opt-code-size
echo "compiled main.c"
sdcc boot.rel crt0.rel main/main.rel -o out/ "-Wl -b_CODE=0x004D" "-Wl -b_DATA=0x8000" "-Wl -bHOME=0x0000"
echo "Linked."
echo "Built."