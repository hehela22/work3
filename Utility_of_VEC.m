function [p_b_opt,p_f_opt,U_VEC_max,U_VEC] = Utility_of_VEC(VehicleList)
%�˺�������VEC���������ռ۸�
 setting;
 
 [~,veh_num] = size(VehicleList);
 
 
 U_VEC = [];
 U_VEC_max = 0; %��ʼ��VEC������Ч��Ϊ0
 p_b_opt = p_b_max; %��ʼ��������Դ�۸�Ϊ��������Դ�۸�
 p_f_opt = p_f_max; %��ʼ��������Դ�۸�Ϊ��������Դ�۸�
    
 b_sell = 0; %���������������Դ֮��
 f_sell = 0; %���������������Դ֮��
 
 iter_num_b = (p_b_max - c_b) / Delta_b;
 iter_num_f = (p_f_max - c_f) / Delta_f;
 
 for i = 1:1:iter_num_b
     p_b_temp = p_b_max - (i-1) * Delta_b;
     for j = 1:1:iter_num_f         
         p_f_temp = p_f_max - (j-1) * Delta_f;
%          b_sell = 0; 
%          f_sell = 0; 
%          for k=1:veh_num
%              [b_k, f_k, ~, ~] = Utility_of_vehicle(VehicleList,k,p_b_temp,p_f_temp);
%              b_sell = b_sell + b_k;
%              f_sell = f_sell + f_k;
%          end
         b_veh = zeros(1,veh_num);
         f_veh = zeros(1,veh_num);
         parfor k=1:veh_num
             [b_k, f_k, ~, ~] = Utility_of_vehicle(VehicleList,k,p_b_temp,p_f_temp);
             b_veh(k) = b_k;
             f_veh(k) = f_k;
         end
         b_sell = sum(b_veh);
         f_sell = sum(f_veh);
         
         if f_sell > F
             break;
         end         
         if b_sell<=B
             U_VEC_temp = (p_b_temp - c_b) * b_sell + (p_f_temp - c_f) * f_sell;
%              U_VEC = [U_VEC, U_VEC_temp];
             if U_VEC_temp > U_VEC_max
                 U_VEC_max = U_VEC_temp;
                 p_b_opt = p_b_temp;
                 p_f_opt = p_f_temp;
             end
         end
     end
 end
end

