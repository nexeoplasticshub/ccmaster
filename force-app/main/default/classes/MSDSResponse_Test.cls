@IsTest
public class MSDSResponse_Test {
	
	static testMethod void testParse() {
		String json = '['+
		'      {'+
		'      \"document\": \"\",'+
		'      \"status\": [],'+
		'      \"dockey\": \"SBRWWI-00000000000006947646 00000\",'+
		'      \"genvar\": \"1_GHS_NA\",'+
		'      \"langu\": \"E\",'+
		'      \"recn_dh\": \"00000000000011583693\",'+
		'      \"material\": \"000000000000020005\",'+
		'      \"genvar_desc\": \"USA - GHS\",'+
		'      \"langu_desc\": \"English\"'+
		'   },'+
		'      {'+
		'      \"document\": \"\",'+
		'      \"status\": [],'+
		'      \"dockey\": \"SBRWWI-00000000000006947647 00000\",'+
		'      \"genvar\": \"1_GHS_NA\",'+
		'      \"langu\": \"F\",'+
		'      \"recn_dh\": \"00000000000011583697\",'+
		'      \"material\": \"000000000000020005\",'+
		'      \"genvar_desc\": \"USA - GHS\",'+
		'      \"langu_desc\": \"French\"'+
		'   },'+
		'      {'+
		'      \"document\": \"\",'+
		'      \"status\": [],'+
		'      \"dockey\": \"SBRWWI-00000000000006947648 00000\",'+
		'      \"genvar\": \"1_GHS_NA\",'+
		'      \"langu\": \"S\",'+
		'      \"recn_dh\": \"00000000000011583701\",'+
		'      \"material\": \"000000000000020005\",'+
		'      \"genvar_desc\": \"USA - GHS\",'+
		'      \"langu_desc\": \"Spanish\"'+
		'   },'+
		'      {'+
		'      \"document\": \"\",'+
		'      \"status\": [],'+
		'      \"dockey\": \"SBRWWI-00000000000006947644 00000\",'+
		'      \"genvar\": \"1_GHS_CA\",'+
		'      \"langu\": \"E\",'+
		'      \"recn_dh\": \"00000000000011583683\",'+
		'      \"material\": \"000000000000020005\",'+
		'      \"genvar_desc\": \"Canada - GHS\",'+
		'      \"langu_desc\": \"English\"'+
		'   },'+
		'      {'+
		'      \"document\": \"\",'+
		'      \"status\": [],'+
		'      \"dockey\": \"SBRWWI-00000000000006947645 00000\",'+
		'      \"genvar\": \"1_GHS_CA\",'+
		'      \"langu\": \"F\",'+
		'      \"recn_dh\": \"00000000000011583687\",'+
		'      \"material\": \"000000000000020005\",'+
		'      \"genvar_desc\": \"Canada - GHS\",'+
		'      \"langu_desc\": \"French\"'+
		'   }'+
		']';
		List<MSDSDocument> listDocuments = MSDSDocument.parse(json);
        MSDSResponse testResponse = new MSDSResponse();
        testResponse.documents = listDocuments;
        testResponse.Status = 'ok';
		System.assert(testResponse != null);
	}
}