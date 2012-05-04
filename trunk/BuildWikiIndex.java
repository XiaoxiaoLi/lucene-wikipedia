import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Hashtable;

public class BuildWikiIndex {
  public static void main(String[] args) throws IOException, ParseException {
	  buildIndex("testIndex","data\\first14711lines-title-and-categories.xml");
  }
  
//Deletes all files and subdirectories under dir.
//Returns true if all deletions were successful.
//If a deletion fails, the method stops attempting to delete and returns false.
	public static boolean deleteDir(File dir) {
	   if (dir.isDirectory()) {
	       String[] children = dir.list();
	       for (int i=0; i<children.length; i++) {
	           boolean success = deleteDir(new File(dir, children[i]));
	           if (!success) {
	               return false;
	           }
	       }
	   }
	
	   // The directory is now empty so delete it
	   return dir.delete();
	}
	
  public static void buildIndex(String indexName, String inputFile) throws IOException {
	    String indexDir = indexName;
		File file = null;
		file = new File(indexDir);
		if (file.exists()){
			deleteDir(file);
		}
	  	
	  	FSDirectory dir = FSDirectory.open(new File(indexDir));

	    StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_36);

	    IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_36, analyzer);

	    IndexWriter indexWriter = new IndexWriter(dir, config);
	  
	  
	  try {
	        BufferedReader in = new BufferedReader(new FileReader(inputFile));
	        String str;
	        String[] items = null;
	        while ((str = in.readLine()) != null) {
	            //process each line
	            Document doc = new Document();
		        
		        items = str.split("-XIAO-");
		        doc.add(new Field("title",items[0],
	                    Field.Store.YES,Field.Index.ANALYZED));
		        doc.add(new Field("category",items[1],
	                    Field.Store.YES,Field.Index.ANALYZED));
		        doc.add(new Field("text",items[2],
		                    Field.Store.YES,Field.Index.ANALYZED));
		        indexWriter.addDocument(doc);
	        }
	        in.close();
	    } catch (IOException e) {
	    }
	    indexWriter.close();
  }
}

