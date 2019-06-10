#Python Webscraping for Cryptocurrency and Ticker List
#Created by Gianluca Capraro in June 2019

#import libraries
import csv
import requests
import lxml.html as lh
import pandas as pd

#define the URL we will point to
url='https://coinmarketcap.com/all/views/all/'
print('\nScraping from Coinmarketcap.com - Table of Top Cryptocurrencies...\n')

#Create a handle, page, to handle the contents of the website
page = requests.get(url)

#Store the contents of the website under doc
doc = lh.fromstring(page.content)

#get the headers
tr_headers = doc.xpath('//tr')

#Create empty list for the columns
columns = []

#Check the length of the first 10 rows
#data from our table should have 11 columns
print('Verify number of columns for first 10 rows:')
print([len(T) for T in tr_headers[:10]])
print('\n')

#For each row, store each header and an empty list
print('Coinmarketcap.com Column Headers:\n')
i = 0
#columns headers are stored in the first row at index 0
for t in tr_headers[0]:
    i+=1
    name = t.text_content()
    print('%d:"%s"'%(i,name))
    columns.append((name,[]))

print('\n')

print('Writing Row Data Into Columns...\n')
#Since the first row is the header, data is stored from the second row on
#we only need the top 500 currencies for now, can adjust later
for j in range(1,501):
    
    #get info from individual row at index j
    T = tr_headers[j]
    
    #check to make sure the row is from our table, we know it should have 11 cols
    if len(T) != 11:
        break
    
    #i is the index of our column
    i=0
    
    #Iterate through each element of the row
    for t in T.iterchildren():
        data = t.text_content() 
        #Check if row is empty
        if i > 0:
        #Convert any numerical value to integers
            try:
                data = int(data)
            except:
                pass
        #Append the data to the empty list of the i'th column
        columns[i][1].append(data)
        #Increment i for the next column
        i+=1

#verify the number of rows for each column, should be the range we set
print('Verify all columns have same number of rows:')
print([len(C) for (title,C) in columns])
print('\n')

#use pandas to create a dataframe from the scraped data
coins_dict = {title: column for (title,column) in columns}
coins_data = pd.DataFrame(coins_dict)

#for mycryptodex, we will only need the Name, Symbol (Abbreviation), and Price of the currency
cryptodex_data = coins_data[['Name','Symbol','Price']]

#however, the name and price columns currently print out strings that are hard to understand
#we need to split the strings, and take the string at index 1, the full name
def getString(string):
    return string.split()[1]

def getPrice(price):
	return price.split()[0]

#use list comprehension to apply the name function on our dataframe
cryptodex_data['Name'] = cryptodex_data['Name'].apply(getString)
cryptodex_data['Price'] = cryptodex_data['Price'].apply(getPrice)

#print out the head to verify your new dataframe has been created successfully
print('\nMyCryptodex Data Head:')
cryptodex_data.index = cryptodex_data.index + 1
print(cryptodex_data)
print('\n')

"""
-----------------------------------------------------------------------------------------
SAVE THE DATAFRAME AS A .CSV FILE
-----------------------------------------------------------------------------------------
The code below will save your scraped data to a .csv file in the folder where this
script is being run.
-----------------------------------------------------------------------------------------
"""
cryptodex_data.to_csv(r'currenttop500coins.csv')
print('Successfully Updated Top 500 Coins List.\n')


