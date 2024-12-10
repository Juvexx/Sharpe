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



mse500=read('asymp/mu3smallabsmse500.txt')
mse1000=read('asymp/mu3smallabsmse1000.txt')
mse1500=read('asymp/mu3smallabsmse1500.txt')
mse2000=read('asymp/mu3smallabsmse2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)
# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5


# fig.subplots_adjust()
ax1.plot(X, np.abs(mse500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[0:30]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mse1500[0:30]), label=r"$n=1500$")
ax1.plot(X, np.abs(mse2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)


ax1.set_xlabel(r'Value of $\mu_0$')
ax1.set_ylabel('MSE of Difference')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/asympmu3smallasympmse.pdf',bbox_inches='tight')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/5
mse500=read('asymp/mu3bigabsmse500.txt')
mse1000=read('asymp/mu3bigabsmse1000.txt')
mse1500=read('asymp/mu3bigabsmse1500.txt')
mse2000=read('asymp/mu3bigabsmse2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9) 
fig.set_figheight(6)

# fig.subplots_adjust()
ax1.plot(X, np.abs(mse500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[0:30]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mse1500[0:30]), label=r"$n=1500$")
ax1.plot(X, np.abs(mse2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)


ax1.set_xlabel(r'Value of $\mu_0$')
ax1.set_ylabel('MSE of Difference')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/asympmu3bigasympmse.pdf',bbox_inches='tight')

#############################mseratio curve##################
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mseratio500=read('asymp/mu3smallabsmseratio500.txt')
mseratio1000=read('asymp/mu3smallabsmseratio1000.txt')
mseratio1500=read('asymp/mu3smallabsmseratio1500.txt')
mseratio2000=read('asymp/mu3smallabsmseratio2000.txt')


# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5
ax1.plot(X, np.abs(mseratio500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[0:30]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mseratio1500[0:30]), label=r"n=1500")
ax1.plot(X, np.abs(mseratio2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $\mu_0$',fontsize=20)
ax1.set_ylabel('MSE of Ratio',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/asympmu3smallasympmseratio.pdf',bbox_inches='tight')


fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mseratio500=read('asymp/mu3bigabsmseratio500.txt')
mseratio1000=read('asymp/mu3bigabsmseratio1000.txt')
mseratio1500=read('asymp/mu3bigabsmseratio1500.txt')
mseratio2000=read('asymp/mu3bigabsmseratio2000.txt')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/5
ax1.plot(X, np.abs(mseratio500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[0:30]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mseratio1500[0:30]), label=r"n=1500")
ax1.plot(X, np.abs(mseratio2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $\mu_0$',fontsize=20)
ax1.set_ylabel('MSE of Ratio',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/asympmu3bigasympmseratio.pdf',bbox_inches='tight')









mse500=read('asymp/mu4smallabsmse500.txt')
mse1000=read('asymp/mu4smallabsmse1000.txt')
mse1500=read('asymp/mu4smallabsmse1500.txt')
mse2000=read('asymp/mu4smallabsmse2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)
# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5


# fig.subplots_adjust()
ax1.plot(X, np.abs(mse500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[0:30]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mse1500[0:30]), label=r"$n=1500$")
ax1.plot(X, np.abs(mse2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)


ax1.set_xlabel(r'Value of $\mu_0$')
ax1.set_ylabel('MSE of Difference')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/asympmu4smallasympmse.pdf',bbox_inches='tight')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/5
mse500=read('asymp/mu4bigabsmse500.txt')
mse1000=read('asymp/mu4bigabsmse1000.txt')
mse1500=read('asymp/mu4bigabsmse1500.txt')
mse2000=read('asymp/mu4bigabsmse2000.txt')

fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9) 
fig.set_figheight(6)

# fig.subplots_adjust()
ax1.plot(X, np.abs(mse500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mse1000[0:30]),  label=r"$n=1000$")
ax1.plot(X, np.abs(mse1500[0:30]), label=r"$n=1500$")
ax1.plot(X, np.abs(mse2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)


ax1.set_xlabel(r'Value of $\mu_0$')
ax1.set_ylabel('MSE of Difference')

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)

plt.savefig('figures/asympmu4bigasympmse.pdf',bbox_inches='tight')

#############################mseratio curve##################
fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mseratio500=read('asymp/mu4smallabsmseratio500.txt')
mseratio1000=read('asymp/mu4smallabsmseratio1000.txt')
mseratio1500=read('asymp/mu4smallabsmseratio1500.txt')
mseratio2000=read('asymp/mu4smallabsmseratio2000.txt')


# X=np.concatenate(([0.01,0.05,0.1],np.arange(1,31)/5))
X=np.arange(1,31)/5
ax1.plot(X, np.abs(mseratio500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[0:30]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mseratio1500[0:30]), label=r"n=1500")
ax1.plot(X, np.abs(mseratio2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $\mu_0$',fontsize=20)
ax1.set_ylabel('MSE of Ratio',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/asympmu4smallasympmseratio.pdf',bbox_inches='tight')


fig, (ax1) = plt.subplots(1, 1, sharex=False)
fig.set_figwidth(9)
fig.set_figheight(6)

# fig.subplots_adjust()
mseratio500=read('asymp/mu4bigabsmseratio500.txt')
mseratio1000=read('asymp/mu4bigabsmseratio1000.txt')
mseratio1500=read('asymp/mu4bigabsmseratio1500.txt')
mseratio2000=read('asymp/mu4bigabsmseratio2000.txt')


#X=np.concatenate(([0.1,0.2,0.4],np.arange(1,31)/1.5))
X=np.arange(1,31)/5
ax1.plot(X, np.abs(mseratio500[0:30]),  label=r"$n=500$")
ax1.plot(X,np.abs(mseratio1000[0:30]),  label=r"$n=1000$")


ax1.plot(X, np.abs(mseratio1500[0:30]), label=r"n=1500")
ax1.plot(X, np.abs(mseratio2000[0:30]), label=r"$n=2000$")
ax1.set_xlim(0, 6.2)

# ax1.set_ylim(0, 1)

ax1.set_xlabel(r'Value of $\mu_0$',fontsize=20)
ax1.set_ylabel('MSE of Ratio',fontsize=20)

ax1.legend(loc='upper left', ncol=1,
        fancybox=True)


plt.savefig('figures/asympmu4bigasympmseratio.pdf',bbox_inches='tight')

