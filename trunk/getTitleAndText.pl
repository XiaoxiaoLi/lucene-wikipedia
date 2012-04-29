#! usr/bin/perl -w
#方法一：Parse::MediaWikiDump的module来做

use Parse::MediaWikiDump;#http://en.wikipedia.org/wiki/Wikipedia:Computer_help_desk/ParseMediaWikiDump
use strict;
my $time1=time();

my $input = 'E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\enwiki-20120403-pages-articles-multistream.xml';
=pod
#my $result = `java Wikipedia2Txt $input`;#可以这样调用java
#print $result;#可以这样调用java
=cut
my $out_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\20120403-titleAndCategories.txt";
open(OUT,">".$out_file)or die "unable to open output file\n";

my $pages = Parse::MediaWikiDump::Pages->new($input);
my $page;

my $counter = 0;
while(defined($page = $pages->next)) {
    #main namespace only
    next unless $page->namespace eq '';
    my $title = $page->title;
    if (!($title=~/\(disambiguation\)/g and $title=~/List of ||Table of /g)){#不是list类型及disambiguation类型的才算一页   	
    	##打印title
    	print OUT $title."-XIAO-";
    	$counter++;
    	if ($counter%10==0){
    		print "done $counter docs\n";
    	}
    	##处理category信息
    	my $categoryInfo="";
    	my $hasLegalCategoryInfo = 0;
    	if (defined $page->categories){#如果有categories信息,redirect先不管，因为存text反倒要耗内存
    		my $cs = $page->categories;    		
    		foreach my $c (@$cs){
    			$c=~s/|.*//;#竖线右边的都删掉，不是*就是链接，不是这的category
    			if ($c!~/[0-9]/){#不要里面带数字的
    				$categoryInfo.=$c."|";#我们打印的时候用|来分割
    				$hasLegalCategoryInfo = 1;
    			}			
    		}
    		if ($hasLegalCategoryInfo == 1){
    			chop($categoryInfo);#去掉末尾多余的|  	
    		}   			
    	}
    	if ($hasLegalCategoryInfo==0){#没有categories信息的
    		$categoryInfo.="NA";#没有的就打None
    	}
    	$categoryInfo.="\n";
    	print OUT $categoryInfo;#打印category的信息
#    	##处理主要文本信息
#    	my $text = $page->text;
#    	my $bodytext = $$text;#指针变成字符串
#    	#不要各种==See also==以及下面的东西
#    	$bodytext=~s/==See also==.*//sg;
#    	$bodytext=~s/== See also ==.*//sg;
#    	$bodytext=~s/== See also==.*//sg;
#    	$bodytext=~s/==See also ==.*//sg;
#    	#去掉各种references
#    	$bodytext=~s/\<ref.*?\<\/ref\>//sg;
#    	$bodytext=~s/&lt;ref.*?&lt;\/ref&gt;//sg;
#    	
#    	#不要[[File开头的附加文件
#    	print OUT $bodytext."\n";
    }   
}

my $time2=time();
my $duration=$time2-$time1;
print "this script took $duration seconds!\n";
close OUT;