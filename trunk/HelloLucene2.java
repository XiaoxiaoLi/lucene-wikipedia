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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Hashtable;

public class HelloLucene2 {
  public static void main(String[] args) throws IOException, ParseException {
	  buildIndex();
	  String toSearch = "category";
	  String[] otherfieldsToSearch = {"title"};
	  searchIndex(toSearch, "cat2", otherfieldsToSearch);
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
  
  public static void buildIndex() throws IOException {
	  	String indexDir = "testIndex";
		File file = null;
		file = new File(indexDir);
		if (file.exists()){
			deleteDir(file);
		}
	  	
	  	
	  	FSDirectory dir = FSDirectory.open(new File(indexDir));

	    StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_36);

	    IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_36, analyzer);

	    IndexWriter indexWriter = new IndexWriter(dir, config);
	    String[] docs = new String[] {  "title1, cat1_cat2, hello world",
	                                     "title2, cat2, hello sailor",
	                                     "title3, cat3, goodnight moon"};
	    String[] items = null;
	    for (String entry : docs) {
	        Document doc = new Document();
	        
	        items = entry.split(", ");
	        doc.add(new Field("title",items[0],
                    Field.Store.YES,Field.Index.ANALYZED));
	        doc.add(new Field("category",items[1],
                    Field.Store.YES,Field.Index.ANALYZED));
	        doc.add(new Field("text",items[2],
	                    Field.Store.YES,Field.Index.ANALYZED));
	        indexWriter.addDocument(doc);
	    }
	    indexWriter.close();
  }
  
  public static void searchIndex(String searchField, String queryString, String[] otherFields) throws IOException, ParseException{
	  
	  IndexSearcher searcher = new IndexSearcher(IndexReader.open(FSDirectory.open(new File("testIndex"))));
	  QueryParser parser = new QueryParser(Version.LUCENE_36, searchField, new StandardAnalyzer(Version.LUCENE_36));
	  System.out.println("nsearching for: " + queryString);
	  Query query = parser.parse(queryString);
	  TopDocs results = searcher.search(query,10);
	  System.out.println("total hits: " + results.totalHits);
	  ScoreDoc[] hits = results.scoreDocs;
	  for (ScoreDoc hit : hits) {
          Document doc = searcher.doc(hit.doc);
//          System.out.printf("%5.3f %sn",
//                            hit.score, doc.get("text"));
          System.out.println(doc.get(searchField) + ": " + doc.get(otherFields[0]));
      }
	  searcher.close();
  }
}
