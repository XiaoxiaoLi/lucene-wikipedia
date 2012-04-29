#! usr/bin/perl -w
#方法一：Parse::MediaWikiDump的module来做

use Parse::MediaWikiDump;#http://en.wikipedia.org/wiki/Wikipedia:Computer_help_desk/ParseMediaWikiDump
use strict;

my $input = 'E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\first14711lines.xml';
my $result = `java Wikipedia2Txt $input`;
print $result;
#my $out_file="E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\parsedXML.txt";
#open(OUT,">".$out_file)or die "unable to open output file\n";
#
#my $pages = Parse::MediaWikiDump::Pages->new($input);
#my $page;
#
#while(defined($page = $pages->next)) {
#    #main namespace only
#    next unless $page->namespace eq '';
#    my $title = $page->title;
#    if (!($title=~/\(disambiguation\)/g and $title=~/List of ||Table of /g)){#不是list类型及disambiguation类型的才算一页   	
#    	##打印title
#    	print OUT "<title>".$title."</title>";
#    	##处理category信息
#    	my $categoryInfo="<c>";
#    	if (defined $page->categories){#如果有categories信息
#    		my $cs = $page->categories;
#    		
#    		foreach my $c (@$cs){
#    			$c=~s/|.*//;#竖线右边的都删掉，不是*就是链接，不是这的category
#    			$categoryInfo.=$c."|";#我们打印的时候用|来分割		
#    		}
#    		chop($categoryInfo);#去掉末尾多余的|
#    	}else{#没有categories信息的
#    		$categoryInfo.="None";#没有的就打None
#    	}
#    	$categoryInfo.="</c>";
#    	print OUT $categoryInfo;#打印category的信息
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
#    }   
#}
#
#close OUT;