#! usr/bin/perl -w
#����һ��Parse::MediaWikiDump��module����

use Parse::MediaWikiDump;#http://en.wikipedia.org/wiki/Wikipedia:Computer_help_desk/ParseMediaWikiDump
use strict;
my $time1=time();

my $input = 'E:\\thesis\\enwiki-20120403-pages-articles-multistream.xml\\enwiki-20120403-pages-articles-multistream.xml';
=pod
#my $result = `java Wikipedia2Txt $input`;#������������java
#print $result;#������������java
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
    if (!($title=~/\(disambiguation\)/g and $title=~/List of ||Table of /g)){#����list���ͼ�disambiguation���͵Ĳ���һҳ   	
    	##��ӡtitle
    	print OUT $title."-XIAO-";
    	$counter++;
    	if ($counter%10==0){
    		print "done $counter docs\n";
    	}
    	##����category��Ϣ
    	my $categoryInfo="";
    	my $hasLegalCategoryInfo = 0;
    	if (defined $page->categories){#�����categories��Ϣ,redirect�Ȳ��ܣ���Ϊ��text����Ҫ���ڴ�
    		my $cs = $page->categories;    		
    		foreach my $c (@$cs){
    			$c=~s/|.*//;#�����ұߵĶ�ɾ��������*�������ӣ��������category
    			if ($c!~/[0-9]/){#��Ҫ��������ֵ�
    				$categoryInfo.=$c."|";#���Ǵ�ӡ��ʱ����|���ָ�
    				$hasLegalCategoryInfo = 1;
    			}			
    		}
    		if ($hasLegalCategoryInfo == 1){
    			chop($categoryInfo);#ȥ��ĩβ�����|  	
    		}   			
    	}
    	if ($hasLegalCategoryInfo==0){#û��categories��Ϣ��
    		$categoryInfo.="NA";#û�еľʹ�None
    	}
    	$categoryInfo.="\n";
    	print OUT $categoryInfo;#��ӡcategory����Ϣ
#    	##������Ҫ�ı���Ϣ
#    	my $text = $page->text;
#    	my $bodytext = $$text;#ָ�����ַ���
#    	#��Ҫ����==See also==�Լ�����Ķ���
#    	$bodytext=~s/==See also==.*//sg;
#    	$bodytext=~s/== See also ==.*//sg;
#    	$bodytext=~s/== See also==.*//sg;
#    	$bodytext=~s/==See also ==.*//sg;
#    	#ȥ������references
#    	$bodytext=~s/\<ref.*?\<\/ref\>//sg;
#    	$bodytext=~s/&lt;ref.*?&lt;\/ref&gt;//sg;
#    	
#    	#��Ҫ[[File��ͷ�ĸ����ļ�
#    	print OUT $bodytext."\n";
    }   
}

my $time2=time();
my $duration=$time2-$time1;
print "this script took $duration seconds!\n";
close OUT;