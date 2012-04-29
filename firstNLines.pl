#! usr/bin/perl -w

#get the first n lines in a file

$n=$ARGV[0];#first n lines

$input_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\enwiki-20120403-pages-articles-multistream.xml";#input file name
$out_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\first".$n."lines.txt";

#$input_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream-index.txt\\enwiki-20120403-pages-articles-multistream-index.txt";#input file name
#$out_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream-index.txt\\first".$n."lines.txt";

open(IN,$input_file)or die "unable to open input file\n";
open(OUT,">".$out_file)or die "unable to open output file\n";

$count=0;
while (<IN>){
  chomp;
  if ($count<$n){
    print OUT "$_\n";
    $count++;
  }
  else{
  	last;
  }
}

print OUT "</mediawiki>\n";#最后一行加个mediawiki

close IN;
close OUT;
