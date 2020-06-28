function [data,flag_task] = Trans(veh_info,TimeToGo)
%������VEC��������
setting;
d = sqrt(d_r^2 + (RoadLength/2 - veh_info(1,1))^2);
if d > Radius
    flag_task = 1; %�����������ʧ��
else
    Rate = veh_info(5,1) * log(1 + P_t * d^(-P_loss) / P_n); %�������� ��λ��bit/s
    data = veh_info(9,1) -  Rate * TimeToGo / 10^6;  
    flag_task = 0;
end

end

