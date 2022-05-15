package kr.happyjob.study.common.comnUtils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 
 * @author edit by.som
 * @author edit by JH / 2022-04-02
 *
 */
public class NewFileUtil {
	
	// DateFormatter
	private static SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// MultipartHttpServletRequest
	private HttpServletRequest HttpServletRequest;
	
	// root file path
	private String rootFilePath;
	
	// virtual file path
	private String virtualRootPath;
	
	// item file path
	private String itemFilePath;	
	
	
	// 이미지 파일 허용 확장자
	@Value("${image.allow.ext}")
	private String allowExt;
	
	
	
	
	public NewFileUtil(HttpServletRequest request, String rootFilePath, String virtualRootPath,
			String itemFilePath) {
		super();
		this.HttpServletRequest = request;
		this.rootFilePath = rootFilePath;
		this.virtualRootPath = virtualRootPath;
		this.itemFilePath = itemFilePath;
	}

	/** 
	 * 파일 추출
	 * <input type=file name="..."> 태그당  등록한 파일들을 Map 객체로 반환
	 * key 는 input tag 의 name 이름이며 value 는 그 태그에 등록한 files 들이다. (List<Multipartfile>)
	 * 
	 */
	public Map<String, List<MultipartFile>> extractFilesMap() throws Exception {
		
		
		
		logger.info("   - uploadFiles() started ");
		
	
		Map<String, List<MultipartFile>> filesListMap=new HashMap<String, List<MultipartFile>>();
		
		
			
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)HttpServletRequest;
		
		Iterator<String> elementOfFileInputs = multipartHttpServletRequest.getFileNames();
		
		
		while(elementOfFileInputs.hasNext()){
		
		
		String inputName=elementOfFileInputs.next();
        	
        	
            
            // input 태그당 등록하려는 파일들 <input type="file" name="file" multiple> 도 고려
            List<MultipartFile> files = multipartHttpServletRequest.getFiles(inputName);
            
//          List<FileModel> fileModelsPerElement = new ArrayList<FileModel>();
            filesListMap.put(inputName, files);

//          fileModelListMap.put(inputName, fileModelsPerElement);
            // Add List<FileModel> to fileModelArray
            // fileModelArray.add(fileModelsPerElement);
        }
        return filesListMap;
	}	
	
	
	// upload Files and return list of them
	public List<FileModel> uploadFiles(List<MultipartFile> updateFiles, String foreignKey) throws Exception {
		
		// 디렉토리 생성
		String dateDir = makeDateDir();
		String uploadFilePath = makeDir(dateDir);
		
		// 파일 정보들을 담은 반환 리스트
		List<FileModel> fileInfoList=null;
		fileInfoList=new LinkedList<>();

        for(MultipartFile multipartFile : updateFiles){
        	
        	
        
        	String ofileName = multipartFile.getOriginalFilename();
            String fileExtension = ofileName.substring(ofileName.lastIndexOf(".")+1);
            String newFileName=renameOfFile(ofileName);
            String localFilePath = uploadFilePath.concat(newFileName);
            String serverFilePath = (virtualRootPath+File.separator)
            														.concat(itemFilePath+File.separator)
			                										.concat(dateDir)
			                										.concat(newFileName);
            int fileSize = (int)multipartFile.getSize();

            //파일 실제 업로드 로직
            File orgFile = new File(localFilePath);
            
            // debugging
            logger.info("   - localFilePath : " + localFilePath);
            logger.info("   - serverFilePath : " + serverFilePath);
            logger.info("   - originalFileName : " + ofileName);
            logger.info("   - newFileName : " + newFileName);
            logger.info("   - fileExtension : " + fileExtension);
            
            // upload
        	multipartFile.transferTo(orgFile);	
            
            
        	
            //디비 등록 용 로직
            FileModel fileModel=new FileModel(
            									serverFilePath.replace(File.separatorChar, '/'),
            									localFilePath.replace(File.separatorChar, '/'), 
            									newFileName, 
            									ofileName, 
            									fileSize, 
            									foreignKey, 
            									fileExtension
        									 );
            
            fileInfoList.add(fileModel);
            
        }
        // end of for loop

		return fileInfoList;
	}
	
	/**
	 * 파일 삭제
	 * @param listFileUtilModel
	 * @throws Exception
	 * JH - static 메소드로 변경
	 * 
	 */
	public static void deleteFiles(List<FileModel> listFileUtilModel) throws Exception {
		
		for(FileModel file : listFileUtilModel){
			
			System.out.println(file.getFile_local_path());
		}
		
		if (listFileUtilModel != null) {
			for(FileModel fileUtilModel : listFileUtilModel) {
				
				// 원본 파일 삭제
				String local_path = fileUtilModel.getFile_local_path().replace('/',File.separatorChar);
				System.out.println(local_path);
				if (local_path != null && !"".equals(local_path)) {
					File file = new File(local_path);
					if (file.exists()){
						System.out.println("파일이 있습니다");
						file.delete();
					}else{
						System.out.println("파일이 없습니다");
					}
				}
			}
		}
	}	
	
	

	/**
	 * 파일명 랜덤 생성
	 * @param File file, String OriginalName
	 * @throws Exception
	 */
    private	String renameOfFile(String originalName) throws Exception{
        // uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
        UUID uuid = UUID.randomUUID();
        // 랜덤생성+파일이름 저장
        String newFileName = uuid.toString()+"_"+originalName;
        return newFileName;
    }    
	/**
	 * 디렉토리 생성
	 * @param itemFilePath // 테이블별 파일관리를 위한 파라미터
	 * 
	 * ex) 공지사항에 관련한 파일들  >> notice 폴더에서 관리
	 * ex) 상품에 관련된 파일들 >> sales 폴더에서 관리
	 */
    
    
	private String makeDir(String dateDir) {
		
		
		
        // 디렉토리 파일 객체 생성
		String uploadFilePath = rootFilePath.concat(File.separator).concat(itemFilePath).concat(File.separator).concat(dateDir);
        File file = new File(uploadFilePath);

        // 경로 생성
        if(!file.isDirectory()){
        	file.mkdirs();
        }
        
        return uploadFilePath.concat(File.separator);
	}    
	
	// 2022 04 01 종현 수정
    // 데이터(파일)들은 날짜별로 관리한다
	private String makeDateDir(){
		return formatter.format(new Date()).concat(File.separator);
	}


    

}
