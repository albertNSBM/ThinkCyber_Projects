#----------------------------------------------------#
#                 Name: ALBERT NSABIMANA             #
#                 SCODE: s30                         #
#                 UNITY: RW-University-II            #
#----------------------------------------------------#

import os
os.system('figlet Log Recon')
import time

# reading the file from /var/log/ called auth.log  that store all changes about our system
with open('/var/log/auth.log','r') as f:
    content=f.readlines()


# function to check all records where the sudo command was used.
def used_sudo():
    for i in content:
        if 'sudo' in i:
            print(i)


# let create another function to check for added user 
def add_suser_check():
    for x in content:
        if 'adduser' in x:
            print(x)

# Now let create the function for checking the deleted users
def user_delete_check():
    for n in content:
        if 'userdel' in n:
            print(n)

# Now let create another function for checking information on password change
def password_chng_check():
    for f in content:
        if 'password' in f:
            print(f)

# for loop function to check who used the su command 
def su_comma_check():
    for m in content:
        if 'COMMAND=/usr/bin/su' in m:
            print(m)

# Let's check if the user failed to use sudo command 
def failed_sudo_check():
    for i in content:
        if 'Failed' and 'COMMAND' in i :
            print(i)

#function that contral all other functions 

def main():
    print('1.All Records where sudo command was used')
    used_sudo()
    print()
    time.sleep(1)

    print('2. All Records of users that have been added ')
    add_suser_check()
    print()
    time.sleep(1)

    print('3.All Records of users that have been deleted')
    user_delete_check()
    print()
    time.sleep(1)

    print('4. All Recods related with Password change')
    password_chng_check()
    print()
    time.sleep(1)

    print('5. All Records where su command was used')
    su_comma_check()
    print()
    time.sleep(1)

    print('6. All Records where sudo command Failed')
    failed_sudo_check()
    print()
    time.sleep(1)

#function call
main()


os.system('figlet Thank You!!')






