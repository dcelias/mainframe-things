import os
import tkinter
from tkinter import filedialog

def checkFile(file):
    #checks if path is a file
    if  os.path.isfile(file): 
        print('Você informou um arquivo')
        return 1
    #checks if path is a directory
    if  os.path.isdir(file): 
        print('Você informou um diretório')
        return 2 

def walkDir(dir):
    # List all files in a directory using os.walk
    for dirpath, dirnames, files in os.walk(dir):
        print(f'Found directory: {dirpath}')
        for file_name in files:
            print(f'Found file: {file_name}')

def showFile(file):
    with open(file, 'r') as f:
        data = f.read()
        print(f'Conteúdo do arquivo:  {data}')

def replaceFile(file, words):
    #input file
    fin = open(file, "rt")

    #output file to write the result to
    root, ext = os.path.splitext(file)
    fout_name = root + "_edited" + ext
    fout = open(fout_name, "wt")
    
    print('Tratando o arquivo...')
    #for each line in the input file
    for line in fin:
    	#read replace the string and write to output file
        print(f'Linha: {line}')

        for x in words: 
            line = line.replace(x, '*EDITED*')

        fout.write(line)

    #close input and output files
    fin.close()
    fout.close()    

def getWords(file):
    sec_words = open(file, "r")
    content_list = sec_words.readlines()
    return content_list


tkinter.Tk().withdraw() # prevents an empty tkinter window from appearing

print('Informe o arquivo que você deseja editar os dados: \n')
path_file  = filedialog.askopenfile().name
type_file  = checkFile(path_file)

print('Informe o arquivo que contém a lista de palavras proibidas: \n')
path_words = filedialog.askopenfile().name
type_words = checkFile(path_words)

if (type_words == 2):
    print('O caminho informado para o arquivo de palavras é inválido.')

if (type_file  == 2):
    print('Working in progress...')
    walkDir(path_file)
else:
    replaceFile(path_file, getWords(path_words))








       