figure(1);
hold on

tmp = nanmean(reshape(rt1(:,2),16,numel(rt1(:,2))/16));
f1 = plot(1:size(tmp,2),tmp,'ko-');

tmp = nanmean(reshape(rt2(:,2),16,numel(rt2(:,2))/16));
f2 = plot(1:size(tmp,2),tmp,'ro-');

tmp = nanmean(reshape(rt3(:,2),16,numel(rt3(:,2))/16));
f3 = plot(1:size(tmp,2),tmp,'bo-');

tmp = nanmean(reshape(rt4(:,2),16,numel(rt4(:,2))/16));
f4 = plot(1:size(tmp,2),tmp,'go-');

legend([f1,f2,f3,f4],'day1','day2','day3','day4')

figure(2)
hold on
l = 96;
tmp = nansum(reshape(rt1(:,1),l,numel(rt1(:,1))/l))/l;
plot(1:size(tmp,2),tmp,'ro-');

tmp = nansum(reshape(rt2(:,1),l,numel(rt2(:,1))/l))/l;
plot(1:size(tmp,2),tmp,'go-');

tmp = nansum(reshape(rt3(:,1),l,numel(rt3(:,1))/l))/l;
plot(1:size(tmp,2),tmp,'bo-');

tmp = nansum(reshape(rt4(:,1),l,numel(rt4(:,1))/l))/l;
plot(1:size(tmp,2),tmp,'ko-');


rt = [rt1(:,2);rt2(:,2);rt3(:,2);rt4(:,2)];
ctx = [ctx1;ctx2;ctx3;ctx4];
figure(3)
hold on
rt_ctx1 = [];
for i = 3:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) == ctx(i-2)
     rt_ctx1 = [rt_ctx1; rt(i)];
   end
end    

rt_ctx2 = [];
for i = 4:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) == ctx(i-3)
        rt_ctx2 = [rt_ctx2; rt(i)];
   end
end

rt_ctx3 = [];
for i = 5:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3) && ctx(i) == ctx(i-4)
        rt_ctx3 = [rt_ctx3; rt(i)];
   end
end

rt_ctx4 = [];
for i = 6:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3) && ctx(i) ~= ctx(i-4) && ctx(i) == ctx(i-5)
        rt_ctx4 = [rt_ctx4; rt(i)];
   end
end

rt_ctx5 = [];
for i = 7:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3) && ctx(i) ~= ctx(i-4) && ctx(i) ~= ctx(i-5) && ctx(i) == ctx(i-6)
        rt_ctx5 = [rt_ctx5; rt(i)];
   end
end

f1 = plot((1:length(rt_ctx1))/length(rt_ctx1),rt_ctx1,'k-');
f2 = plot((1:length(rt_ctx2))/length(rt_ctx2),rt_ctx2,'r-');
f3 = plot((1:length(rt_ctx3))/length(rt_ctx3),rt_ctx3,'b-');
f4 = plot((1:length(rt_ctx4))/length(rt_ctx4),rt_ctx4,'g-');
f5 = plot((1:length(rt_ctx5))/length(rt_ctx5),rt_ctx5,'c-');

legend([f1,f2,f3,f4,f5],'lag1','lag2','lag3','lag4','lag5')

figure(4)
hold on
f1 = plot(1,nanmean(rt_ctx1),'o','markersize',16);
f2 = plot(2,nanmean(rt_ctx2),'o','markersize',16);
f3 = plot(3,nanmean(rt_ctx3),'o','markersize',16);
f4 = plot(4,nanmean(rt_ctx4),'o','markersize',16);
f5 = plot(5,nanmean(rt_ctx5),'o','markersize',16);
%%%%%%%%%%%%%%%%%%%%%%%%%
rt = [rt1(:,1);rt2(:,1);rt3(:,1);rt4(:,1)];
ctx = [ctx1;ctx2;ctx3;ctx4];
figure(5)
hold on
rt_ctx1 = [];
for i = 2:length(rt)
   if ctx(i) ~= ctx(i-1)
     rt_ctx1 = [rt_ctx1; rt(i)];
   end
end    

rt_ctx2 = [];
for i = 3:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2)
        rt_ctx2 = [rt_ctx2; rt(i)];
   end
end

rt_ctx3 = [];
for i = 4:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3)
        rt_ctx3 = [rt_ctx3; rt(i)];
   end
end

rt_ctx4 = [];
for i = 5:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3) && ctx(i) ~= ctx(i-4)
        rt_ctx4 = [rt_ctx4; rt(i)];
   end
end

rt_ctx5 = [];
for i = 6:length(rt)
   if ctx(i) ~= ctx(i-1) && ctx(i) ~= ctx(i-2) && ctx(i) ~= ctx(i-3) && ctx(i) ~= ctx(i-4) && ctx(i) ~= ctx(i-5)
        rt_ctx5 = [rt_ctx5; rt(i)];
   end
end

f1 = plot(1,nansum(rt_ctx1)/length(rt_ctx1),'o','markersize',16);
f2 = plot(2,nansum(rt_ctx2)/length(rt_ctx2),'o','markersize',16);
f3 = plot(3,nansum(rt_ctx3)/length(rt_ctx3),'o','markersize',16);
f4 = plot(4,nansum(rt_ctx4)/length(rt_ctx4),'o','markersize',16);
f5 = plot(5,nansum(rt_ctx5)/length(rt_ctx5),'o','markersize',16);