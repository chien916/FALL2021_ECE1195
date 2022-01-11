restart

add_force -radix dec i_vec_dataIn 888
add_force i_l_enable 1
add_force i_l_shift 1
add_force i_l_control 0
add_force i_l_clock 0
run 10ns

add_force i_l_reset 1
run 10ns

add_force i_l_clock 1
run 10ns
add_force i_l_clock 0
run 10ns

add_force i_l_reset 0
run 10ns


add_force i_l_clock 1
run 10ns
add_force i_l_clock 0
run 10ns
add_force i_l_clock 1
run 10ns
add_force i_l_clock 0
run 10ns
add_force i_l_clock 1
run 10ns