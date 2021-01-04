clear; clc; close all;

path = ('D:\Project\Online\Context_Learning\Adrian_Data'); % the data folder path
folder = dir(path);
cd(path);

load pilot_data;

xplot = 0:0.001:1.2;
x_size = 0.15;

col = ['r','g'];
line_type = ['-','--',':','-.'];
lw = 1.2;

Ctx = {'Ctx-1','Ctx-2'};
Stim = ['a','b','c','d'];
Key = ['h','u','i','l'];
%%% plot TR block
TR_Session = figure('name','TR_Session1');
TR_Session2 = figure('name','TR_Session2');
sub_id = unique(DATA.participant);
for i = 1:numel(sub_id)
   tmp = [];
   tmp = DATA(DATA.participant == sub_id(i),:);
   
   ind_blk_type = (all(char(tmp.Block_Type) == 'TR',2));
   ind_stim_type = (all(char(tmp.Stim_Type) == 'Symb',2));
   
   data = tmp(ind_blk_type == 1 & ind_stim_type == 1,:);
   
   for sess = (unique(data.Session))'
       tmp = [];
       tmp = data(data.Session == sess, :);
       sess_ind = find(sess == (unique(data.Session))');
       if sess_ind == 1
           figure(TR_Session);
       elseif sess_ind == 2
           figure(TR_Session2);
       end
       for c = 1:numel(unique(tmp.ctx))
           sub_plot_ind = find(unique(tmp.Session) == sess);
           subplot(4,2,[1:4]);
           set(gcf,'color','w');
           hold on
           tt = ['Session-' num2str(sess)];
           title(tt,'FontSize',12, 'FontWeight','normal');
           xlabel('PT','FontSize',12, 'FontWeight','normal');
           ylabel('Probability','FontSize',12, 'FontWeight','normal');
           tmp_ctx = [];
           tmp_ctx = tmp(tmp.ctx == c,:);
           blk_ind = (tmp_ctx.Block_Num == 1 | tmp_ctx.Block_Num == 2 | tmp_ctx.Block_Num == 3 ...
               | tmp_ctx.Block_Num == 4);
           tmp_blocked = tmp_ctx(blk_ind,:);
           prep_time = tmp_blocked.TR_Press_rt - 1.6 + tmp_blocked.Set_Prep_Time;
           [f N] = sliding_window(prep_time, tmp_blocked.TR_Press_corr, xplot,x_size);
           f1 = plot(xplot,f,'color',col(c),'LineStyle','--','LineWidth',2);
           
           blk_ind = (tmp_ctx.Block_Num == 5 | tmp_ctx.Block_Num == 6);
           tmp_blocked = tmp_ctx(blk_ind,:);
           prep_time = tmp_blocked.TR_Press_rt - 1.6 + tmp_blocked.Set_Prep_Time;
           [f N] = sliding_window(prep_time, tmp_blocked.TR_Press_corr, xplot,x_size);
           f2 = plot(xplot,f,'color',col(c),'LineStyle','-','LineWidth',2);
           clear f;
           legend([f1,f2],{'blocked','random'})
           for stim = 0:3
                subplot(4,2,stim+5);
                set(gcf,'color','w');
                hold on
                tmp_stim = [];
                tmp_stim = tmp_ctx(tmp_ctx.Symbol == stim,:);
                blk_ind = (tmp_stim.Block_Num == 1 | tmp_stim.Block_Num == 2 | tmp_stim.Block_Num == 3 ...
               | tmp_stim.Block_Num == 4);
                tmp_blocked = tmp_stim(blk_ind,:);
                prep_time = tmp_blocked.TR_Press_rt - 1.6 + tmp_blocked.Set_Prep_Time;
                [f N] = sliding_window(prep_time, tmp_blocked.TR_Press_corr, xplot,x_size);
                f = plot(xplot,f,'color',col(c),'LineStyle','--','linewidth',lw);
                clear f;
%                 blk_ind = (tmp_stim.Block_Num == 5 | tmp_stim.Block_Num == 6 );
%                 tmp_blocked = tmp_stim(blk_ind,:);
%                 prep_time = tmp_blocked.TR_Press_rt - 1.6 + tmp_blocked.Set_Prep_Time;
%                 [f N] = sliding_window(prep_time, tmp_blocked.TR_Press_corr, xplot,x_size);
%                 g = plot(xplot,f,'color',col(c),'LineStyle','-','linewidth',lw);
           end
       end
   end
end


%%% plot TR block
TR_Habit = figure('name','TR_Habit');
sub_id = unique(DATA.participant);
key_index = [];
for i = 1:numel(sub_id)
   tmp = [];
   tmp = DATA(DATA.participant == sub_id(i),:);
   key_tmp = tmp.stim_key_map_ctx1(~cellfun(@isempty,tmp.stim_key_map_ctx1));
   key_index(1,:) = str2num(char(unique(key_tmp)));
   
   key_tmp = tmp.stim_key_map_ctx2(~cellfun(@isempty,tmp.stim_key_map_ctx2));
   key_index(2,:) = str2num(char(unique(key_tmp)));
   
   ind_blk_type = (all(char(tmp.Block_Type) == 'TR',2));
   ind_stim_type = (all(char(tmp.Stim_Type) == 'Symb',2));
   
   data = tmp(ind_blk_type == 1 & ind_stim_type == 1,:);
   
   for sess = (unique(data.Session))'
       tmp = [];
       tmp = data(data.Session == sess, :);
       sess_ind = find(sess == (unique(data.Session))');
       for c = 1:numel(unique(tmp.ctx))
           tmp_ctx = [];
           tmp_ctx = tmp(tmp.ctx == c,:);
           blk_ind = (tmp_ctx.Block_Num == 5 | tmp_ctx.Block_Num == 6);
           tmp_blocked = tmp_ctx(blk_ind,:);
           
           tmp_blocked.habit(:) = 0;
           tmp_blocked.other(:) = 0;
           
           if c == 1
               c_alter = 2;
           elseif c == 2
               c_alter = 1;
           end
           for j = 1:length(tmp_blocked.habit)
               if char(tmp_blocked.TR_Press_keys(j)) == Key(key_index(c_alter,tmp_blocked.Symbol(j) + 1)+1)
                   tmp_blocked.habit(j) = 1;
               end
               if (isempty(char(tmp_blocked.TR_Press_keys(j))) || char(tmp_blocked.TR_Press_keys(j))~= Key(key_index(c_alter,tmp_blocked.Symbol(j) + 1)+1)) && tmp_blocked.TR_Press_corr(j) == 0
                   tmp_blocked.other(j) = 1;
               end
           end
           
           subplot(2,1,sess_ind);
           set(gcf,'color','w');
           hold on
           tt = ['Session-' num2str(sess)];
           title(tt,'FontSize',12, 'FontWeight','normal');
           xlabel('PT','FontSize',12, 'FontWeight','normal');
           ylabel('Probability','FontSize',12, 'FontWeight','normal');
           
           prep_time = tmp_blocked.TR_Press_rt - 1.6 + tmp_blocked.Set_Prep_Time;
           [f N] = sliding_window(prep_time, tmp_blocked.habit, xplot,x_size);
           f1 = plot(xplot,f,'color',col(c),'LineStyle','-','LineWidth',2);
           clear f;
           
           [f N] = sliding_window(prep_time, tmp_blocked.other, xplot,x_size);
           f2 = plot(xplot,f,'color',col(c),'LineStyle','--','LineWidth',2);
           clear f;
           
           legend([f1,f2],{'habit','other'})
       end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% RT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sub_id = unique(DATA.participant);
for i = 1:numel(sub_id)
   tmp = [];
   tmp = DATA(DATA.participant == sub_id(i),:);
   
   ind_blk_type = (all(char(tmp.Block_Type) == 'RT',2));
   ind_stim_type = (all(char(tmp.Stim_Type) == 'Symb',2));
   
   data = tmp(ind_blk_type == 1 & ind_stim_type == 1,:);
   
   rt_ctx = [];
   ac_ctx = [];
   for c = 1:numel(unique(data.ctx))
       tmp_ctx = [];
       tmp_ctx = data(data.ctx == c,:);
       for stim = 0:3
           rt = [];
           ac = [];
           tmp_stim = [];
           tmp_stim = tmp_ctx(tmp_ctx.Symbol == stim,:);
           for sess = (unique(tmp_stim.Session))'
               tmp = [];
               tmp = tmp_stim(tmp_stim.Session == sess, :);
               for blk = (unique(tmp.Block_Num))'
                   tmp_blk = tmp(tmp.Block_Num == blk,:);
                   tmp_rt = nanmean(tmp_blk.RT_Press_rt);
                   tmp_ac = nanmean(tmp_blk.RT_Press_corr);
                   rt = [rt; tmp_rt];
                   ac = [ac; tmp_ac];
               end
           end
           rt_ctx(:,stim + 1 + 4*(c-1)) = rt;
           ac_ctx(:,stim + 1 + 4*(c-1)) = ac;
       end
   end
end
       
RT_Ctx = figure('name','RT_Ctx');
AC_Ctx = figure('name','AC_Ctx');       
       
figure(RT_Ctx);
subplot(4,2,[1:4]);
set(gcf,'color','w');
hold on
title('RT','FontSize',12, 'FontWeight','normal');
xlabel('Block','FontSize',12, 'FontWeight','normal');
ylabel('RT','FontSize',12, 'FontWeight','normal');

rt_ctx1 = nanmean(rt_ctx(:,1:4),2);
rt_ctx2 = nanmean(rt_ctx(:,5:8),2);                  

plot(rt_ctx1,'color',col(1),'LineStyle','-','LineWidth',2);
plot(rt_ctx2,'color',col(2),'LineStyle','-','LineWidth',2);
             
for stim = 1:4
    subplot(4,2,stim+4);
    hold on
    plot(rt_ctx(:,stim),'color',col(1),'LineStyle','-','LineWidth',2);
    plot(rt_ctx(:,stim+4),'color',col(2),'LineStyle','-','LineWidth',2);
    %axis([0,50,0,3])
end

figure(AC_Ctx);
subplot(4,2,[1:4]);
set(gcf,'color','w');
hold on
title('Accuracy','FontSize',12, 'FontWeight','normal');
xlabel('Block','FontSize',12, 'FontWeight','normal');
ylabel('Accuracy','FontSize',12, 'FontWeight','normal');

ac_ctx1 = nanmean(ac_ctx(:,1:4),2);
ac_ctx2 = nanmean(ac_ctx(:,5:8),2);                  

plot(ac_ctx1,'color',col(1),'LineStyle','-','LineWidth',2);
plot(ac_ctx2,'color',col(2),'LineStyle','-','LineWidth',2);
             
for stim = 1:4
    subplot(4,2,stim+4);
    hold on
    plot(ac_ctx(:,stim),'color',col(1),'LineStyle','-','LineWidth',2);
    plot(ac_ctx(:,stim+4),'color',col(2),'LineStyle','-','LineWidth',2);
end

% switching in TR
%%% plot TR block
TR_Session_SW = figure('name','TR_Session1_SW');
TR_Session2_SW = figure('name','TR_Session2_SW');
sub_id = unique(DATA.participant);
for i = 1:numel(sub_id)
   tmp = [];
   tmp = DATA(DATA.participant == sub_id(i),:);
   
   ind_blk_type = (all(char(tmp.Block_Type) == 'TR',2));
   ind_stim_type = (all(char(tmp.Stim_Type) == 'Symb',2));
   
   data = tmp(ind_blk_type == 1 & ind_stim_type == 1,:);
   
   for sess = (unique(data.Session))'
       tmp = [];
       tmp = data(data.Session == sess, :);
       sess_ind = find(sess == (unique(data.Session))');
       if sess_ind == 1
           figure(TR_Session_SW);
       elseif sess_ind == 2
           figure(TR_Session2_SW);
       end
           blk_ind = (tmp.Block_Num == 5 | tmp.Block_Num == 6);
           tmp_blocked = tmp(blk_ind,:);
           prep_time_sw = [];
           prep_time_sw2 = [];
           prep_time = [];
           corr_sw = [];
           corr = [];
           corr_sw2 = [];
           sub_plot_ind = find(unique(tmp.Session) == sess);
           subplot(4,2,[1:4]);
           set(gcf,'color','w');
           hold on
           tt = ['Session-' num2str(sess)];
           title(tt,'FontSize',12, 'FontWeight','normal');
           xlabel('PT','FontSize',12, 'FontWeight','normal');
           ylabel('Probability','FontSize',12, 'FontWeight','normal');
           
           for i = 3:size(tmp_blocked,1)
               if tmp_blocked.ctx(i) ~= tmp_blocked.ctx(i-1) && tmp_blocked.ctx(i) == tmp_blocked.ctx(i-2)
                   prep_time_sw = [prep_time_sw, tmp_blocked.TR_Press_rt(i) - 1.6 + tmp_blocked.Set_Prep_Time(i)];
                   corr_sw = [corr_sw, tmp_blocked.TR_Press_corr(i)];
               elseif tmp_blocked.ctx(i) == tmp_blocked.ctx(i-1)
                   prep_time = [prep_time, tmp_blocked.TR_Press_rt(i) - 1.6 + tmp_blocked.Set_Prep_Time(i)];
                   corr = [corr, tmp_blocked.TR_Press_corr(i)];
               elseif tmp_blocked.ctx(i) ~= tmp_blocked.ctx(i-1) && tmp_blocked.ctx(i) ~= tmp_blocked.ctx(i-2)
                   prep_time_sw2 = [prep_time_sw2, tmp_blocked.TR_Press_rt(i) - 1.6 + tmp_blocked.Set_Prep_Time(i)];
                   corr_sw2 = [corr_sw2, tmp_blocked.TR_Press_corr(i)];
               end
           end
           [f N] = sliding_window(prep_time, corr, xplot,x_size);
           f1 = plot(xplot,f,'color',col(c),'LineStyle','-','LineWidth',2);
           clear f;
           [f N] = sliding_window(prep_time_sw, corr_sw, xplot,x_size);
           f2 = plot(xplot,f,'color',col(c),'LineStyle','--','LineWidth',2);
           clear f;
%            [f N] = sliding_window(prep_time_sw2, corr_sw2, xplot,x_size);
%            f3 = plot(xplot,f,'color',col(c),'LineStyle',':','LineWidth',2);
%            clear f;
           legend([f1,f2],{'consistent','switch'})
   end
end