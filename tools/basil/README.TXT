This is Basil version 5.3.1 for Linux, released 21 March 2002

This package includes the following:

  basil
     basil executable

  basilsim
     basil parser simulator executable

  source
     This directory contains the source code you must link with your
     parser.  This should be portable code.  You will need lzz version
     1.5 or higher to translate this code into C++.

     User Files:
       basl_Attrib.lzz            base attribute
       basl_AttribPtr.lzz         attribute smart pointer
       basl_ErrorRec.lzz          syntax error recover stategies
       basl_FreeToken.lzz         token without location
       basl_FreeTokenVector.lzz   std::vector of free tokens
       basl_Lexer.lzz             base lexer class
       basl_Messages.lzz          error messages
       basl_Node.lzz              node definition
       basl_Nonterm.lzz           nonterminal definition
       basl_Parse.lzz             parse interface function
       basl_Parser.lzz            base parser class definition
       basl_PrintSyntaxTree.lzz   prints syntax tree to output stream
       basl_SyntaxTree.lzz        syntax tree definition
       basl_Token.lzz             token definition
       util_Ident.lzz             unique identifier (or any string)
       util_IdentTable.lzz        table for storing unique identifiers
       util_IdentToString.lzz     converts identifier to string
       util_Loc.lzz               location of token (file location)
       util_LocToString.lzz       converts location to string
       util_String.lzz            std::string

     Implementation Files:
       basl_LRBTParser.lzz        the backtracking parser
       basl_LRData.lzz            definitions of generated data structures
       basl_NodePool.lzz          node memory manager 
       basl_NontermInfo.lzz       info for generated nonterminals
       basl_NontermProxy.lzz      base class of generated nonterminal
       basl_RecCmd.lzz            recovery strategy
       basl_RecCmdPtrDeque.lzz    std::deque of recovery strategies
       basl_RefStack.lzz          reference counted stack implementation
       basl_TokenList.lzz         std::list of tokens
       basl_Visitor.lzz           base visitor class definition
       util_BPtr.lzz              reference counted smart pointer for base
                                  classes
       util_CharKeyTable.lzz      table for storing unique char strings
       util_DPtr.lzz              reference counted smart pointer for
                                  derived classes
       util_KeyTable.lzz          table for storing strings of some type

Basil documentation, as well as the latest version, is available at
http://www.lazycplusplus.com/basil.

Lzz is available at http://www.lazycplusplus.com.

Please send comments, questions and bug reports to
michael_spencer@lazycplusplus.com.
     
