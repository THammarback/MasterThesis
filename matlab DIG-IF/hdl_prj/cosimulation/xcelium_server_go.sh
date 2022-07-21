#!/bin/bash  
# Args: name server_files hdl_files server_address server_path port
if (( $# == 6 )); then
  ssh "$4" "mkdir" "$5"
  scp $2 $4:$5
  ssh "$4" "mkdir" "$5$1"
  scp $3 $4:$5$1
  ssh "$4" "cd $5; set NAME=$1; set PORT='$6'; source run_xcelium.tcl; /bin/rm -r $1"
else
  echo "Expects 6 arguments: name server_files hdl_files server_address server_path port"
  echo "Ex: DIG_IF hdl_prj/cosimulation/server_files/* hdl_prj/hdlsrc/DIG_IF_test/*.vhd user@server ~/Documents/temp 1337"
  /bin/bash -i
fi