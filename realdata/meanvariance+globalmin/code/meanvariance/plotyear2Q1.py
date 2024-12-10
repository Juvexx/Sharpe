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
def getvalue(path):
    with open(path, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        # print(spamreader)
        value=[]
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                value.append(row[1:36])
            a+=1
    return np.array(value)


listsd=getvalue('meanvariance/year2/listSRQ1.csv')

listsd=listsd.astype(float)


fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(9)

# # # fig.subplots_adjust()
data=[]
for i in range(16):
    data.append(listsd[i,4:34])
    
optim=[]
for i in range(16):
    optim.append(listsd[i,1])


print(listsd[:,0].astype(int).astype(str))
# data=[listsd[0,3:34],listsd[1,3:34],listsd[2,3:34],listsd[3,3:34]]
ax1.boxplot(data)
ax1.set_xticklabels(listsd[:,0].astype(int).astype(str))
ax1.set_xlabel('Time',fontsize=20)

ax1.set_ylabel('Sharpe Ratio',fontsize=20)
# ax1.set_ylim(ymax=1)


ax1.scatter(range(1,17),optim,60,marker='^',label=r'Optimal',color='red')
plt.xticks(rotation=270)
plt.plot(range(1,17),listsd[:,2],label=r'Standard')
plt.plot(range(1,17),listsd[:,4],label=r'$q=0.1$',linestyle='dashdot')
plt.plot(range(1,17),listsd[:,33],label=r'$q=3$',linestyle='dashed')
# plt.plot(range(1,17),listsd[:,4],label=r'$q=2/3$',linestyle='dashdot')
# plt.plot(range(1,17),listsd[:,33],label=r'$q=20$',linestyle='dashed')
ax1.legend(loc='upper right', ncol=1,
        fancybox=True)
plt.savefig('figures/meanvariance/meanvarianceyear2Q1.pdf',bbox_inches='tight')
plt.show()

