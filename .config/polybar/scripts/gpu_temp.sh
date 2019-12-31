temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
echo " "$temp"°C"
