import crypt
 
def testPass(cryptPass):
hashType = cryptPass.split("$")[1]
if hashType == '1':
print "[+] Hash Type is MD5"
elif hashType == '5':
print "[+] Hash Type is SHA-256"
elif hashType == '6':
print "[+] Hash Type is SHA-512"
else:
"[+] Hash Type is Unknown"
 
salt = cryptPass.split("$")[2]
dictFile = open('dictionary.txt', 'r')
for word in dictFile.readlines():
word = word.strip('\n')
pepper = "$" + hashType + "$" + salt
cryptWord = crypt.crypt(word, pepper)
if cryptWord == cryptPass:
print '[+] Found Password: ' + word + '\n'
return
print '[-] Password Not Found.\n'
return
 
def main():
passFile = open('passwords.txt')
for line in passFile.readlines():
if ':' in line:
user = line.split(':')[0]
cryptPass = line.split(':')[1].strip(' ')
print '[*] Cracking Password For: ' + user
testPass(cryptPass)
 
if __name__ == '__main__':
main()
