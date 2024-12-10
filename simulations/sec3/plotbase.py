import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import csv
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
# Fixing random state for reproducibility
matplotlib.rcParams.update({'font.size': 22})
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
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                listlambda.append(float(row[1]))
                SRknown.append(float(row[2]))
                SRunknown.append(float(row[3]))
            a+=1
    return listlambda,SRknown,SRunknown


listSRknown=0
listSRunknown=0
for repeat0 in range(1000):
    pathsmall='mu3/c>1/n='
    listlambda,SRknown,SRunknown=getmean(pathsmall+'1500Sigmaelserepeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    known=listSRknown/1000
    unknown=listSRunknown/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(np.sqrt(known[1:30]),listlambda[1:30],color='black',label=r'$\sigma_0$')
plt.scatter(np.sqrt(unknown[1:30]),listlambda[1:30],color='black',label=r'$\widehat{\sigma}$')
ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)
ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)
plt.savefig('mu3Sigma2c>1.pdf',bbox_inches='tight')



listSRknown=0
listSRunknown=0
for repeat0 in range(1000):
    pathsmall='mu3/c<1/n='
    listlambda,SRknown,SRunknown=getmean(pathsmall+'1500Sigmaelserepeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    known=listSRknown/1000
    unknown=listSRunknown/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(np.sqrt(known[1:30]),listlambda[1:30],color='black',label=r'$\sigma_0$')
plt.scatter(np.sqrt(unknown[1:30]),listlambda[1:30],color='black',label=r'$\widehat{\sigma}$')
ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)
ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)
plt.savefig('mu3Sigma2c<1.pdf',bbox_inches='tight')




listSRknown=0
listSRunknown=0
for repeat0 in range(1000):
    pathsmall='mu4/c<1/n='
    listlambda,SRknown,SRunknown=getmean(pathsmall+'1500Sigmaelserepeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    known=listSRknown/1000
    unknown=listSRunknown/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(np.sqrt(known[1:30]),listlambda[1:30],color='black',label=r'$\sigma_0$')
plt.scatter(np.sqrt(unknown[1:30]),listlambda[1:30],color='black',label=r'$\widehat{\sigma}$')
ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)
ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)
plt.savefig('mu4Sigma2c<1.pdf',bbox_inches='tight')



listSRknown=0
listSRunknown=0
for repeat0 in range(1000):
    pathsmall='mu4/c>1/n='
    listlambda,SRknown,SRunknown=getmean(pathsmall+'1500Sigmaelserepeat'+str(repeat0+1)+'.csv')
    listSRknown=listSRknown+np.array(SRknown)
    listSRunknown=listSRunknown+np.array(SRunknown)
    known=listSRknown/1000
    unknown=listSRunknown/1000
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

print(listlambda)
ax1.plot(np.sqrt(known[1:30]),listlambda[1:30],color='black',label=r'$\sigma_0$')
plt.scatter(np.sqrt(unknown[1:30]),listlambda[1:30],color='black',label=r'$\widehat{\sigma}$')
ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)
ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)
ax1.legend(loc='lower right', ncol=1,
        fancybox=True)
plt.savefig('mu4Sigma2c>1.pdf',bbox_inches='tight')











# listSRknown=0
# listSRunknown=0
# for repeat0 in range(100):
#     pathbig='mu1/c>1/n='
#     listlambda,SRknown,SRunknown=getmean(pathbig+'1500q=3repeat'+str(repeat0+1)+'.csv')
#     listSRknown=listSRknown+np.array(SRknown)
#     listSRunknown=listSRunknown+np.array(SRunknown)
#     known=listSRknown/100
#     unknown=listSRunknown/100
# fig, (ax1) = plt.subplots(1, 1, sharex=False)
# fig.set_figwidth(9)
# fig.set_figheight(6)

# print(listlambda)
# ax1.plot(np.sqrt(known[1:20]),listlambda[1:20],color='black',label=r'$\sigma_0$')
# plt.scatter(np.sqrt(unknown[1:20]),listlambda[1:20],color='black',label=r'$\widehat{\sigma}$')
# ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)
# ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)
# ax1.legend(loc='lower right', ncol=1,
#         fancybox=True)

# plt.savefig('bigcompareq=3.pdf',bbox_inches='tight')



