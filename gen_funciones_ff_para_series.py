import requests

def gen_data_post(v, max_bits):
    datapost = {'calctype': 'sop'}

    for i in range(2**max_bits):
        datapost['in' + str(i)] = 'x'

    for i in v:
        datapost['in' + str(i[0])] = i[1]
    datapost['drawtype'] = 'htmlcss'
    return datapost

def gen_dic(max_bits):
    dic = {}

    initial = 'A'
    end = chr(64 + max_bits)
    aux = end

    while initial != end:
        dic[initial] = aux
        aux = chr(ord(aux) - 1)
        initial = chr(ord(initial) + 1)
    dic[initial] = aux
    return dic
def solv(max_bits, f, dic_aux, eq):

    page = "http://www.32x8.com/"

    dire = "circuits" + str(max_bits)

    datapost = gen_data_post(f, max_bits)

    r = requests.post(page + dire, data = datapost)
    t = r.text

    sw = False

    for i in range(len(t) - 3):
        if sw:
            if t[i] == '<':
                break
            if ord(t[i]) >= 65 and ord(t[i]) <= 90:
                print(dic_aux[t[i]], end = " ")
            else:
                print(t[i], end = " ")
        if t[i] + t[i + 1] + t[i + 2] == "y =":
            sw = True
            print(eq, end = " ")

n = int(input("[+] Cuantos numeros son: "))

v = list()

my = -1

aux = list()

for _ in range(n):
    x = int(input("[-] Introduce: "))
    aux.append(x)
    my = max(my, x)
    v.append(str(bin(x))[2::])

max_bits = len(str(bin(my))[2::])

trans = list()

for i in range(len(v)):
    v[i] = "0" * (max_bits - len(v[i])) + v[i]
    
for i in range(len(v) - 1):
    trans.append(v[i + 1])
trans.append(v[0])

print("DEC\tBIN\tTRANS", end = "\t")

for i in range(max_bits - 1, -1, - 1):
    leter = chr(65 + i)
    print("J" + leter + " K" + leter, end = "\t")
print()

v_funciones = list()

for i in range(2 * max_bits):
    v_funciones.append(list())

for i in range(len(v)):
    print(aux[i], "     ", v[i], "\t", trans[i], end = "\t")

    elem1 = v[i]
    elem2 = trans[i]
    pos = 0

    for j in range(max_bits):

        bit1 = int(elem1[j])
        bit2 = int(elem2[j])

        if bit1 == 0 and bit2 == 1:
            v_funciones[pos].append((aux[i], '1'))
            v_funciones[pos + 1].append((aux[i], 'x'))
            print("1  X", end = "\t")
        elif bit1 == 1 and bit2 == 0:
            v_funciones[pos].append((aux[i], 'x'))
            v_funciones[pos + 1].append((aux[i], '1'))
            print("X  1", end = "\t")
        elif bit1 == 0 and bit2 == 0:
            v_funciones[pos].append((aux[i], '0'))
            v_funciones[pos + 1].append((aux[i], 'x'))
            print("0  X", end = "\t")
        elif bit1 == 1 and bit2 == 1:
            v_funciones[pos].append((aux[i], 'x'))
            v_funciones[pos + 1].append((aux[i], '0'))
            print("X  0", end = "\t")
        pos += 2
    print()


dic_aux = gen_dic(max_bits)

jk_functions = list()

pos = 0
for i in dic_aux:
    jk_functions.append(("J" + dic_aux[i], v_funciones[pos]))
    jk_functions.append(("K" + dic_aux[i], v_funciones[pos + 1]))

    pos += 2

for i in jk_functions:

    eq = i[0]

    f = i[1]

    solv(max_bits, f, dic_aux, eq)
    print()
