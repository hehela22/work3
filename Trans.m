function [data,flag_task] = Trans(veh_info,TimeToGo)
%车辆和VEC传输任务
setting;
d = sqrt(d_r^2 + (RoadLength/2 - veh_info(1,1))^2);
if d > Radius
    flag_task = 1; %传输计算任务失败
else
    Rate = veh_info(5,1) * log(1 + P_t * d^(-P_loss) / P_n); %传输速率 单位：bit/s
    data = veh_info(9,1) -  Rate * TimeToGo / 10^6;  
    flag_task = 0;
end

end

