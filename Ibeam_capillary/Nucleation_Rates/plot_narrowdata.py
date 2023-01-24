import numpy as np
import matplotlib.pyplot as plt


y = [333333333.333, 416666666.667, 555555555.556]
ticklabels= [r'$\frac{1}{\infty}$', r'$\frac{1}{30 \AA}$', r'$\frac{1}{24 \AA}$', r'$\frac{1}{18 \AA}$']

bounds= [2.63/2, 2.55/2, 3.3/2]

unconfined = [0, 227.8, 4/2]

narrow_cap = [y, [228.34, 228.78, 227.8],[2.36/2, 2.2385/2, 3/2]]
cap = [y, [230.48, 231.75, 234], [2.63/2, 2.55/2, 3.3/2]]



a = plt.subplot(111)

#plt.plot([1,-500], un_fit, 'k--') 
#plt.plot([1,-500], eight_fit, 'b--') 
plt.errorbar(unconfined[0], unconfined[1], yerr=unconfined[2], fmt='ko', alpha=0.8, capsize=5.0, label='1 atm reference value')
plt.errorbar(narrow_cap[0], narrow_cap[1], yerr=narrow_cap[2], fmt='rd', alpha=0.8, linewidth=1.0, capsize=5.0, label='Narrow capillary bridges')
plt.errorbar(cap[0], cap[1], yerr=cap[2], fmt='bD', alpha=0.5, linewidth=1.0, capsize=5.0, label='Capillary bridges')

#plt.xlim(0, 0.2)
#plt.ylim(0, 8)
plt.xlabel(r'1/h ($\AA^{-1}$) where h=capillary height')
plt.ylabel(r'Temperature (K) of $J_{het}=10^{24}$ s$^{-1}$m$^{-2}$')
#plt.grid(color='#d4d4d4', linestyle='--', linewidth=1)
plt.xticks([0, 333333333.333, 416666666.667, 555555555.556], ticklabels)

#plt.legend(loc='upper left', bbox_to_anchor=(0.5, 1.05), ncol=1, fancybox=True, shadow=True)

plt.legend(loc='upper left', ncol=1, fancybox=True, shadow=True)

plt.savefig('narrow.png', dpi=1000)
