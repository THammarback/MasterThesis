source setup183
xmvhdl -v93 -smartlib -messages $NAME/*.vhd
xmelab -64bit -access +rwc -vhdl_time_precision 1ns $NAME -messages -mccodegen
xmsim $NAME -64bit -tcl -loadvpi /export/space/local-sw/matlab/instr2019b/toolbox/edalink/extensions/incisive/linux64/liblfihdls_gcc41.so:simlinkserver +socket=$PORT
