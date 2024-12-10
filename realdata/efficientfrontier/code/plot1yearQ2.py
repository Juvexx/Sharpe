import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import csv
# Fixing random state for reproducibility
from matplotlib.ticker import MaxNLocator
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


font1={'family':'Times New Roman','weight':'normal','size':20}
def getvalue(path):
    with open(path, newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        # print(spamreader)
        value=[]
        a=0
        for row in spamreader:
            # print(', '.join(row))
            if a>0:
                value.append(row[1:35])
            a+=1
    return np.array(value)


listsd=getvalue('meanvariance/1yearQ2/listsd.csv')

listsd=listsd.astype(float)

# print(listsd)

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(9)

# # # fig.subplots_adjust()
data=[]
for i in range(15):
    data.append(listsd[i,3:33])
    
optim=[]
for i in range(15):
    optim.append(listsd[i,1])
    
yaxis=listsd[:,0]
# print(optim)
# print(listsd[:,0].astype(float).astype(str))
# data=[listsd[0,3:34],listsd[1,3:34],listsd[2,3:34],listsd[3,3:34]]
ax1.boxplot(data,0,vert=0,positions=yaxis)
# ax1.set_yticklabels(listsd[:,0].astype(float).astype(str))
ax1.set_xlabel(r'Value of $\sigma$',fontsize=20)

ax1.set_ylabel(r'Value of $\mu_0$',fontsize=20)



# ax1.set_ylim(ymin=4.5)


# plt.plot(optim,yaxis)
print(optim)
print(yaxis)
plt.ylim(top=6.5)
ax1.scatter(optim,yaxis,60,marker='^',label=r'Optimal',color='red')
plt.xticks(fontproperties='Times New Roman')
# plt.yticks(fontproperties = 'Times New Roman', size = 14)
# plt.xticks(fontproperties = 'Times New Roman', )
plt.yticks(fontproperties='Times New Roman',size = 20)
plt.plot(listsd[:,2],yaxis,label=r'Standard')
plt.plot(listsd[:,3],yaxis,label=r'$q=0.1$',linestyle='dashdot')
plt.plot(listsd[:,32],yaxis,label=r'$q=3$',linestyle='dashed')

plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))
ax1.legend(loc='upper left', ncol=1,
        fancybox=True)
plt.savefig('1yearQ2.pdf',bbox_inches='tight')
plt.show()

