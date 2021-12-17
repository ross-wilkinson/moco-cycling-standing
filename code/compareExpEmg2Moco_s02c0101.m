% Compare experimental and MocoInverse muscle activity

%% Load data
expData = readtable('s02c0101dataPmax.xlsx');
sol = importdata('3DCycling_MocoInverse_solution_s02c0101.sto','\t');
mocoData = array2table(sol.data,'VariableNames',sol.colheaders);

%% normalize time vector
expData.time = expData.time - expData.time(1);
mocoData.time = mocoData.time - mocoData.time(1);

%% Create figure
figure('color','w','position',[50 50 600 500])

%% Gluteus maximus
ax1 = subplot(3,2,1);
plot(expData.time,expData.GlutMax,'k','linewidth',2)
hold on
plot(mocoData.time, mocoData.("/forceset/glmax1_r/activation"),'r','linewidth',2)
legend({'Experiment','MocoInverse'},'box','off')

box off
xlabel('Time (s)')
ylabel('Activation')
title('GMax')
ax1.TitleHorizontalAlignment = 'left';

%% Biceps femoris long head
ax2 = subplot(3,2,2);
plot(expData.time,expData.BF,'k','linewidth',2)
hold on
plot(mocoData.time, mocoData.("/forceset/bflh140_r/activation"),'r','linewidth',2)

box off
xlabel('Time (s)')
ylabel('Activation')
title('BFlh')
ax2.TitleHorizontalAlignment = 'left';

%% Rectus femoris
ax3 = subplot(3,2,3);
plot(expData.time,expData.RF,'k','linewidth',2)
hold on
plot(mocoData.time, mocoData.("/forceset/recfem_r/activation"),'r','linewidth',2)

box off
xlabel('Time (s)')
ylabel('Activation')
title('RF')
ax3.TitleHorizontalAlignment = 'left';

%% Vatsus lateralis
ax4 = subplot(3,2,4);
plot(expData.time,expData.VL,'k','linewidth',2)
hold on
plot(mocoData.time, mocoData.("/forceset/vaslat140_r/activation"),'r','linewidth',2)

box off
xlabel('Time (s)')
ylabel('Activation')
title('VL')
ax4.TitleHorizontalAlignment = 'left';

%% Gastroc medialis
ax5 = subplot(3,2,5);
plot(expData.time,expData.GastrocMed,'k','linewidth',2)
hold on
plot(mocoData.time, mocoData.("/forceset/gasmed_r/activation"),'r','linewidth',2)

box off
xlabel('Time (s)')
ylabel('Activation')
title('MG')
ax5.TitleHorizontalAlignment = 'left';


