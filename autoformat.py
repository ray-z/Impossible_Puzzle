def split_len(str, size):
    return [str[i:i+size] for i in range(0, len(str), size)]

n = 80 # line length

input = open('input.txt', 'r')
line = input.read()
input.close()

list = split_len(line,n)

output = open('output.txt', 'w')
for item in list:
    output.write('%s\n' % item)
output.close()
