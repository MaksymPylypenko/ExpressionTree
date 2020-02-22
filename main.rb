require "./operator"
require "./variable"
require "./constant"
require "./expression"

# COMP2150 A4
# Pylypenko Maksym 7802672
# pylypenm@myumanitoba.ca

#------------------------------------------------
#Main
#------------------------------------------------

#tokeniser
def makeTokens(line)
  # print(line)
  tokens=line.split(/(\W)/).select { |s| s != '' }  #scan(/\W|[\w.]+/).select { |s| s != " " }
  # print("Tokens: ")
  # puts(tokens.length)
  
  #handle negative numbers 
  i = 0 
  j = i+1
  length = tokens.length 
  while i < length 
    if ( tokens[i]=="-" or tokens[i]=="(" or tokens[i]=="+") and tokens[j]=="-" 
      tokens[j+1]="-"+tokens[j+1] #merge minus with the next token
      tokens[j]=nil #setup space 
    end
    i+=1
    j+=1
  end
  tokens = tokens.compact   #remove spaces 
  # print(tokens)
  # puts
  return tokens
end

# read routine
def read(file)
  File.open(file) do |f1|
    while line = f1.gets #gets gets nil @ eof
      command = line.split
      if command[0] == "comment"
        line = f1.gets
        puts line
      elsif command[0] == "read"
        tree = ExpressionTree.new(makeTokens(f1.gets))
        root = tree.root
      elsif command[0] == "printInfix"
        tree.printInorder(root) if defined? tree
        puts()
      elsif command[0] == "printPostfix"
        tree.printPostorder(root) if defined? tree
        puts()
      elsif command[0] == "printPrefix"
        tree.printPreorder(root) if defined? tree
        puts()
      elsif command[0] == "displayStructure"
        tree.displayStructure(root) if defined? tree
      elsif command[0] == "assign"
        variable = makeTokens(f1.gets)
        subTree = ExpressionTree.new(makeTokens(f1.gets))
        tree.merge(variable[0],subTree) if defined? tree
      elsif command[0] == "simplify"
        root = tree.simplify(root) if defined? tree
      end
      
    end
  end
end

# validate args
if ARGV.length == 1
  read(ARGV[0])
else
  read("test2.txt")
end
