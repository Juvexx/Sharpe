import numpy as np
import matplotlib
import matplotlib.pyplot as plt

matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
# Fixing random state for reproducibility
matplotlib.rcParams.update({'font.size': 22})

def read(path0):
    with open(path0, "r") as f:
        temp=[line[:-1] for line in f]
        del(temp[0])
    data=[float(re) for re in temp]
    return(data)



mseratio500=read('asymp/smallabsmseratio500.txt')
mseratio1000=read('asymp/smallabsmseratio1000.txt')
mseratio1500=read('asymp/smallabsmseratio1500.txt')
mseratio2000=read('asymp/smallabsmseratio2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)
# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5


# fig.subplots_adjust()
ax1.plot(X, np.abs(mseratio500[3:34]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[3:34]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mseratio1500[3:34]), label=r"$n=1500$")
ax1.plot(X, np.abs(mseratio2000[3:34]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)


ax1.set_xlabel(r'Value of $q$')
ax1.set_ylabel('MSE of Ratio')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/smallasympmseratio.pdf',bbox_inches='tight')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/1.5
mseratio500=read('asymp/bigabsmseratio500.txt')
mseratio1000=read('asymp/bigabsmseratio1000.txt')
mseratio1500=read('asymp/bigabsmseratio1500.txt')
mseratio2000=read('asymp/bigabsmseratio2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
ax1.plot(X, np.abs(mseratio500[3:34]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[3:34]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mseratio1500[3:34]), label=r"$n=1500$")
ax1.plot(X, np.abs(mseratio2000[3:34]), label=r"$n=2000$")
ax1.set_xlim(0, 20.2)


ax1.set_xlabel(r'Value of $q$')
ax1.set_ylabel('MSE of Ratio')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/bigasympmseratio.pdf',bbox_inches='tight')

#############################mse curve##################
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mse500=read('asymp/smallabsmse500.txt')
mse1000=read('asymp/smallabsmse1000.txt')
mse1500=read('asymp/smallabsmse1500.txt')
mse2000=read('asymp/smallabsmse2000.txt')


# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5
ax1.plot(X, np.abs(mse500[3:34]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[3:34]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mse1500[3:34]), label=r"n=1500")
ax1.plot(X, np.abs(mse2000[3:34]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $q$',fontsize=20)
ax1.set_ylabel('MSE of Difference',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/smallasympmse.pdf',bbox_inches='tight')


fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mse500=read('asymp/bigabsmse500.txt')
mse1000=read('asymp/bigabsmse1000.txt')
mse1500=read('asymp/bigabsmse1500.txt')
mse2000=read('asymp/bigabsmse2000.txt')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/1.5
ax1.plot(X, np.abs(mse500[3:34]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[3:34]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mse1500[3:34]), label=r"n=1500")
ax1.plot(X, np.abs(mse2000[3:34]), label=r"$n=2000$")
ax1.set_xlim(0, 20.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $q$',fontsize=20)
ax1.set_ylabel('MSE of Difference',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/bigasympmse.pdf',bbox_inches='tight')



###########################boxplot_optimal_q######

import csv

def getdiff_q(path):
    with open(path, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        # print(spamreader)
        listlambda=[]
        SRknown=[]
        SRunknown=[]
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                listlambda.append(float(row[1]))
                SRknown.append(float(row[2]))
                SRunknown.append(float(row[3]))
            a+=1
    index_known=np.array(SRknown).argmax()
    index_unknown=np.array(SRunknown).argmax()
    return (listlambda[index_known]-listlambda[index_unknown])
path='Basecase/c<1/n=500repeat2.csv'
print(getdiff_q(path))
smalldiffq_500=[]
smalldiffq_1000=[]
smalldiffq_1500=[]
smalldiffq_2000=[]

bigdiffq_500=[]
bigdiffq_1000=[]
bigdiffq_1500=[]
bigdiffq_2000=[]
for repeat0 in range(1000):
    pathsmall='Basecase/c<1/n='
    smalldiffq_500.append(getdiff_q(pathsmall+'500repeat'+str(repeat0+1)+'.csv'))
    smalldiffq_1000.append(getdiff_q(pathsmall+'1000repeat'+str(repeat0+1)+'.csv'))
    smalldiffq_1500.append(getdiff_q(pathsmall+'1500repeat'+str(repeat0+1)+'.csv'))
    smalldiffq_2000.append(getdiff_q(pathsmall+'2000repeat'+str(repeat0+1)+'.csv'))
    pathbig='Basecase/c>1/n='
    bigdiffq_500.append(getdiff_q(pathbig+'500repeat'+str(repeat0+1)+'.csv'))
    bigdiffq_1000.append(getdiff_q(pathbig+'1000repeat'+str(repeat0+1)+'.csv'))
    bigdiffq_1500.append(getdiff_q(pathbig+'1500repeat'+str(repeat0+1)+'.csv'))
    bigdiffq_2000.append(getdiff_q(pathbig+'2000repeat'+str(repeat0+1)+'.csv'))

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()


data=[smalldiffq_500,smalldiffq_1000,smalldiffq_1500,smalldiffq_2000]
ax1.boxplot(data)
ax1.set_xticklabels([r"$n=500$", r"$n=1000$", 
                    r"$n=1500$", r"$n=2000$"])
ax1.set_xlabel('Different n',fontsize=20)
ax1.set_ylabel(r'Difference on $q^*$',fontsize=20)
plt.savefig('figures/smallasympboxq.pdf',bbox_inches='tight')




fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()


data=[bigdiffq_500,bigdiffq_1000,bigdiffq_1500,bigdiffq_2000]
ax1.boxplot(data)
ax1.set_xticklabels([r"$n=500$", r"$n=1000$", 
                    r"$n=1500$", r"$n=2000$"])
ax1.set_xlabel('Different n',fontsize=20)

ax1.set_ylabel(r'Difference on $q^*$',fontsize=20)
plt.savefig('figures/bigasympboxq.pdf',bbox_inches='tight')













###########################boxplot_optimal_q######

import csv

def getdiff_SR(path):
    with open(path, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        # print(spamreader)
        listlambda=[]
        SRknown=[]
        SRunknown=[]
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                listlambda.append(float(row[1]))
                SRknown.append(float(row[2]))
                SRunknown.append(float(row[3]))
            a+=1
    index_known=np.array(SRknown).argmax()
    index_unknown=np.array(SRunknown).argmax()
    return (SRknown[index_known]-SRunknown[index_unknown])
path='Basecase/c<1/n=500repeat2.csv'
print(getdiff_SR(path))
smalldiffSR_500=[]
smalldiffSR_1000=[]
smalldiffSR_1500=[]
smalldiffSR_2000=[]

bigdiffSR_500=[]
bigdiffSR_1000=[]
bigdiffSR_1500=[]
bigdiffSR_2000=[]
for repeat0 in range(1000):
    pathsmall='Basecase/c<1/n='
    smalldiffSR_500.append(getdiff_SR(pathsmall+'500repeat'+str(repeat0+1)+'.csv'))
    smalldiffSR_1000.append(getdiff_SR(pathsmall+'1000repeat'+str(repeat0+1)+'.csv'))
    smalldiffSR_1500.append(getdiff_SR(pathsmall+'1500repeat'+str(repeat0+1)+'.csv'))
    smalldiffSR_2000.append(getdiff_SR(pathsmall+'2000repeat'+str(repeat0+1)+'.csv'))
    pathbig='Basecase/c>1/n='
    bigdiffSR_500.append(getdiff_SR(pathbig+'500repeat'+str(repeat0+1)+'.csv'))
    bigdiffSR_1000.append(getdiff_SR(pathbig+'1000repeat'+str(repeat0+1)+'.csv'))
    bigdiffSR_1500.append(getdiff_SR(pathbig+'1500repeat'+str(repeat0+1)+'.csv'))
    bigdiffSR_2000.append(getdiff_SR(pathbig+'2000repeat'+str(repeat0+1)+'.csv'))

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

fig.subplots_adjust()


data=[smalldiffSR_500,smalldiffSR_1000,smalldiffSR_1500,smalldiffSR_2000]
ax1.boxplot(data)
ax1.set_xticklabels([r"$n=500$", r"$n=1000$", 
                    r"$n=1500$", r"$n=2000$"])
ax1.set_xlabel('Different n',fontsize=20)
ax1.set_ylabel('Difference on SR',fontsize=20)
plt.savefig('figures/smallasympboxSR.pdf',bbox_inches='tight')




fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

fig.subplots_adjust()


data=[bigdiffSR_500,bigdiffSR_1000,bigdiffSR_1500,bigdiffSR_2000]
ax1.boxplot(data)
ax1.set_xticklabels([r"$n=500$", r"$n=1000$", 
                    r"$n=1500$", r"$n=2000$"])
ax1.set_xlabel('Different n',fontsize=20)

ax1.set_ylabel('Difference on SR',fontsize=20)
plt.savefig('figures/bigasympboxSR.pdf',bbox_inches='tight')



