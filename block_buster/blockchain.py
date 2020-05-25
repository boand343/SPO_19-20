from web3 import Web3
import numpy as np
import matplotlib.pyplot as plt

with open('project_secret') as f:
	text = f.read()
	ID = text[0 : text.find('\n')]
	secret = text[text.find('\n') + 1 : len(text)]

web3 = Web3(Web3.HTTPProvider("https://mainnet.infura.io/" + ID))

reward = 2
K = 36
start = 8961400 - 10 * (K - 1)
end = 8961400 - 10 * (K - 2)
wei_to_eth = 10 ** -18 
abs_fee = []
rel_fee = []
block_number = []
sum_of_SC = []


def trans(block):
	fee = 0
	suminput = 0
	for transaction in block.transactions:
		gasuse = web3.eth.getTransactionReceipt(transaction.hash).gasUsed
                price = transaction.gasPrice
                fee += gasuse * price
		if len(transaction.input) > 2:
			suminput += 1
	return fee * wei_to_eth, suminput

for number in range(start, end):
	block = web3.eth.getBlock(number, True)
	fee, suminp = trans(block)
	block_number.append(number)
	abs_fee.append(fee)
	block_reward = reward + abs_fee[-1] + len(block.uncles) * 5 / 32
	rel_fee.append( abs_fee[-1] * 100 / block_reward)
	sum_of_SC.append(suminp)
	
Mx = np.mean(abs_fee)
Dx = np.var(abs_fee)
Standard_deviation = Dx ** (1 / 2)
median = np.median(abs_fee)
razmah = np.max(abs_fee) - np.min(abs_fee)

plt.subplot(2, 1, 1)
plt.plot(block_number, abs_fee)
plt.xlabel('Номер блока')
plt.ylabel('Абсолютное значение, ETH')

plt.subplot(2, 1, 2)
plt.plot(block_number, rel_fee)
plt.xlabel('Номер блока')
plt.ylabel('Относительное значение, %')
plt.show()
