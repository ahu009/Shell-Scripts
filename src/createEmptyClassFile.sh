#!/bin/sh

$1

touch $1.hh
touch $1.cc

cat abe_861148832.txt > $1.hh
cat abe_861148832.txt > $1.cc

echo "#ifndef ${1}_hh\n#define $1_hh \n\nclass $1 \n{\n    public:" >> $1.hh
echo "    $1();\n    ~$1(); \n\n    private:\n};\n#endif" >> $1.hh

echo "#include \"./$1.hh\" \n\n$1::$1()\n{}\n\n$1::~$1()\n{}\n" >> $1.cc


