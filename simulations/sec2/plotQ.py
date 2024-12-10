import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import csv
# Fixing random state for reproducibility
matplotlib.rcParams.update({'font.size': 22})
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
matplotlib.rcParams['text.usetex'] = True
plt.rcParams.update(
    {
        "text.usetex": True,
        "text.latex.preamble": r"\usepackage{amsmath}",
    }
)
def getmean(path):
    with open(path, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        # print(spamreader)
        listlambda=[]
        SRknown=[]
        SRunknown=[]
        SRmax=[]
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                listlambda.append(float(row[1]))
                SRknown.append(float(row[2]))
                SRunknown.append(float(row[3]))
                SRmax.append(float(row[4]))
            a+=1
    return listlambda,SRknown,SRunknown,SRmax


listSRknown=0
listSRunknown=0
listSRmax=0

for repeat0 in range(1000):
    pathsmall='Q/c<1/Q'
    listlambda,SRknown,SRunknown,SRmax=getmean(pathsmall+'1repeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    listSRmax=listSRmax+np.array(SRmax)
    known=listSRknown/1000
    unknown=listSRunknown/1000
    srmax=listSRmax/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(listlambda[3:34],known[3:34],color='black',label=r'$SR(\mathbf{Q})$')
ax1.plot(listlambda[3:34],srmax[3:34],linestyle='-.',color='black',label=r'$SR_{\text{max}}$')
plt.scatter(listlambda[3:34],unknown[3:34],color='black',label=r'$\widehat{SR}(\mathbf{Q})$')
ax1.set_xlabel('Value of q',fontsize=20)
ax1.set_ylabel('Value of SR',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)

plt.savefig('figures/smallQ1.pdf',bbox_inches='tight')









listSRknown=0
listSRunknown=0
listSRmax=0

for repeat0 in range(1000):
    pathsmall='Q/c<1/Q'
    listlambda,SRknown,SRunknown,SRmax=getmean(pathsmall+'2repeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    listSRmax=listSRmax+np.array(SRmax)
    known=listSRknown/1000
    unknown=listSRunknown/1000
    srmax=listSRmax/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(listlambda[3:34],known[3:34],color='black',label=r'$SR(\mathbf{Q})$')
ax1.plot(listlambda[3:34],srmax[3:34],linestyle='-.',color='black',label=r'$SR_{\text{max}}$')
plt.scatter(listlambda[3:34],unknown[3:34],color='black',label=r'$\widehat{SR}(\mathbf{Q})$')
ax1.set_xlabel('Value of q',fontsize=20)
ax1.set_ylabel('Value of SR',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)

plt.savefig('figures/smallQ2.pdf',bbox_inches='tight')








listSRknown=0
listSRunknown=0
listSRmax=0

for repeat0 in range(1000):
    pathsmall='Q/c>1/Q'
    listlambda,SRknown,SRunknown,SRmax=getmean(pathsmall+'1repeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    listSRmax=listSRmax+np.array(SRmax)
    known=listSRknown/1000
    unknown=listSRunknown/1000
    srmax=listSRmax/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(listlambda[3:34],known[3:34],color='black',label=r'$SR(\mathbf{Q})$')
ax1.plot(listlambda[3:34],srmax[3:34],linestyle='-.',color='black',label=r'$SR_{\text{max}}$')
plt.scatter(listlambda[3:34],unknown[3:34],color='black',label=r'$\widehat{SR}(\mathbf{Q})$')
ax1.set_xlabel('Value of q',fontsize=20)
ax1.set_ylabel('Value of SR',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)

plt.savefig('figures/bigQ1.pdf',bbox_inches='tight')






listSRknown=0
listSRunknown=0
listSRmax=0

for repeat0 in range(1000):
    pathsmall='Q/c>1/Q'
    listlambda,SRknown,SRunknown,SRmax=getmean(pathsmall+'2repeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    listSRmax=listSRmax+np.array(SRmax)
    known=listSRknown/1000
    unknown=listSRunknown/1000
    srmax=listSRmax/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(listlambda[3:34],known[3:34],color='black',label=r'$SR(\mathbf{Q})$')
ax1.plot(listlambda[3:34],srmax[3:34],linestyle='-.',color='black',label=r'$SR_{\text{max}}$')
plt.scatter(listlambda[3:34],unknown[3:34],color='black',label=r'$\widehat{SR}(\mathbf{Q})$')
ax1.set_xlabel('Value of q',fontsize=20)
ax1.set_ylabel('Value of SR',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)

plt.savefig('figures/bigQ2.pdf',bbox_inches='tight')