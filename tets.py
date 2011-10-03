import functools

def menu(elems):
	while True:
		for i, e in enumerate(elems):
			print (i, e[0])

		choix = int(input())

		elems[choix][1]()


def lister(l):
	for i in l:
		print (i)

def main():
	l = range(1, 100)

	def somme():
		print (functools.reduce(lambda a, b: a+b, l))
	
	def diff():
		print (functools.reduce(lambda a, b: a-b, l))


	elems = [["Lister les nombres", lambda: lister(l)],
		["Sommer les nombres", somme],
		["Différences des nombres", diff]]

	menu(elems)

	elems2 = [["afficher 1", lambda: print (1)],
		["afficher 1", lambda: print (2)]
	]

	menu(elems2)

main()
