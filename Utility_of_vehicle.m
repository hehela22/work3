function [b_opt, f_opt, beta_opt,U_opt] = Utility_of_vehicle(VehicleList,index,p_b,p_f)
%此函数返回每个车辆的最优带宽和计算资源
 setting;
 
 [k,t_max] = Mean_k(VehicleList,index);
 
 tmp = cell(1,3);
 %边界f=F,0<=b<=B
 if Alpha*Data*k*omega^2 / (VehicleList(4,index)^2)<=p_b
     tmp{1,1} = [0,F];
 elseif Alpha*Data*omega^2*k*F^2 / (k*B*omega*F+VehicleList(4,index)*(F+k*B*omega))^2>=p_b
     tmp{1,1} = [B,F];
 else
     tmp{1,1} = [(F*omega*sqrt(Alpha*Data*k/p_b)-VehicleList(4,index)*F)/(k*omega*(F+VehicleList(4,index))),F];
 end
 
 %边界b=B,0<=f<=F
 if Alpha*Data*omega / (VehicleList(4,index)^2)<=p_f
     tmp{1,2} = [B,0];
 elseif Alpha*Data*omega^3*k^2*B^2 / (k*B*omega*F+VehicleList(4,index)*(F+k*B*omega))^2>=p_f
     tmp{1,2} = [B,F];
 else
     tmp{1,2} = [B,(omega*k*B*sqrt(Alpha*Data*omega/p_f) - VehicleList(4,index)*omega*k*B)/(omega*k*B+VehicleList(4,index))];
 end
 
 %其余两个边界
 tmp{1,3} = [0,0];

 %驻点
 syms b f;
 
 U(b,f) = Alpha*(t_max - omega*Data*(f+k*b*omega)/(k*b*f*omega+VehicleList(4,index)*(f+k*b*omega)))...
     -p_b*b-p_f*f;
 
 U_partial_f = Alpha*Data*omega^3*k^2*b^2/(omega*k*b*f+VehicleList(4,index)*(f+omega*k*b))^2 - p_f;

 U_partial_b = Alpha*Data*omega^2*k*f^2/(omega*k*b*f+VehicleList(4,index)*(f+omega*k*b))^2 - p_b;

 [b_sta,f_sta] = solve(U_partial_b ,U_partial_f); %驻点集合，一般有4个点
 
 b_sta = double(b_sta);
 f_sta = double(f_sta);
 
 [sta_num,~] = size(b_sta); %驻点个数
 
 exist_flag = 0; %可行域内是否有驻点指示变量，初始为0
 
 for i=1:1:sta_num
     if 0<=b_sta(i) && b_sta(i)<=B && 0<=f_sta(i) && f_sta(i)<=F
         b_opt = b_sta(i);
         f_opt = f_sta(i);
         exist_flag = 1;
         break;
     end
 end
 
 if ~exist_flag
    U_max_init = -10^9;
    for i=1:3
        if i<3
            if double(eval(U(tmp{1,i}(1),tmp{1,i}(2)))) > U_max_init
                U_max_init = double(eval(U(tmp{1,i}(1),tmp{1,i}(2))));
                b_opt = tmp{1,i}(1);
                f_opt = tmp{1,i}(2);
            end
        else
            U_not_offload = Alpha*(t_max - omega*Data/VehicleList(4,index));
            if U_not_offload > U_max_init
                 U_max_init = U_not_offload;
                 b_opt = 0;
                 f_opt = 0;
            end
        end
    end
 end
 
 if (exist_flag && double(eval(U(b_opt,f_opt)))>0) || (~exist_flag && U_max_init > 0)
     %卸载到VEC的任务比例
     if b_opt>0 || f_opt>0
        U_opt = double(eval(U(b_opt,f_opt)));
        beta_opt = 1 - VehicleList(4,index)*(f_opt + b_opt*k*omega)/(omega*k*b_opt*f_opt+VehicleList(4,index)*(f_opt+omega*k*b_opt));
     else
        U_opt = Alpha*(t_max - omega*Data/VehicleList(4,index));
        beta_opt = 0;
        b_opt = 0;
        f_opt = 0;
     end   
 else
     U_opt = Alpha*(t_max - omega*Data/VehicleList(4,index));
     beta_opt = 0;
     b_opt = 0;
     f_opt = 0;
 end
 
 
end

