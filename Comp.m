function [data] = Comp(veh_info,TimeToGo)
% VEC计算来自车辆的任务
  setting;
  
  data = veh_info(10,1) - veh_info(6,1) * (TimeToGo /10^6) /omega;  
   
end

