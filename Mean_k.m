function [k_index,t_max_index] = Mean_k(VehicleList,index)
%UNTITLED3 此处显示有关此函数的摘要
setting;
t_res_index = (RoadLength - VehicleList(1,index))/(VehicleList(3,index)/3.6);

t_max_index = min(t_res_index,VehicleList(7,index));

syms t;

d = sqrt(d_r^2 + (RoadLength/2 - VehicleList(1,index) - VehicleList(3,index)/3.6*t)^2);

SINR = P_t*d^(-P_loss)/P_n;

k_index =  double(int(log(1+SINR), t, 0, t_max_index))/t_max_index;

end

