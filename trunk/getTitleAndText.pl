#! usr/bin/perl -w
#����һ��Parse::MediaWikiDump��module����

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
#    if (!($title=~/\(disambiguation\)/g and $title=~/List of ||Table of /g)){#����list���ͼ�disambiguation���͵Ĳ���һҳ   	
#    	##��ӡtitle
#    	print OUT "<title>".$title."</title>";
#    	##����category��Ϣ
#    	my $categoryInfo="<c>";
#    	if (defined $page->categories){#�����categories��Ϣ
#    		my $cs = $page->categories;
#    		
#    		foreach my $c (@$cs){
#    			$c=~s/|.*//;#�����ұߵĶ�ɾ��������*�������ӣ��������category
#    			$categoryInfo.=$c."|";#���Ǵ�ӡ��ʱ����|���ָ�		
#    		}
#    		chop($categoryInfo);#ȥ��ĩβ�����|
#    	}else{#û��categories��Ϣ��
#    		$categoryInfo.="None";#û�еľʹ�None
#    	}
#    	$categoryInfo.="</c>";
#    	print OUT $categoryInfo;#��ӡcategory����Ϣ
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
#    }   
#}
#
#close OUT;