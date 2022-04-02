(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("frameLogin");
            this.set_titletext("frameLogin");
            this.set_background("");
            if (Form == this.constructor)
            {
                this._setFormPosition(1040,720);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsSearch", this);
            obj._setContents("<ColumnInfo><Column id=\"id\" type=\"STRING\" size=\"256\"/><Column id=\"password\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"id\"/><Col id=\"password\"/></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsList", this);
            obj._setContents("");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsMember", this);
            obj._setContents("<ColumnInfo><Column id=\"level\" type=\"STRING\" size=\"256\"/><Column id=\"groupId\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuNm\" type=\"STRING\" size=\"256\"/><Column id=\"menuUrl\" type=\"STRING\" size=\"256\"/><Column id=\"sortNo\" type=\"STRING\" size=\"256\"/><Column id=\"upMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000005</Col><Col id=\"menuNm\">프로젝트</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000006</Col><Col id=\"menuNm\">목록</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA00000007</Col><Col id=\"menuNm\">자료실</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">Q&amp;A</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000008</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">자유게시판</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000009</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000010</Col><Col id=\"menuNm\">자료실</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col><Col id=\"menuUrl\">pattern::pattern03-file.xfdl</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000011</Col><Col id=\"menuNm\">My Page</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000012</Col><Col id=\"menuNm\">My Info</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000013</Col><Col id=\"menuNm\">쪽지</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000014</Col><Col id=\"menuNm\">지원현황</Col><Col id=\"menuUrl\">pattern::pattern03-file.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsAdmin", this);
            obj._setContents("<ColumnInfo><Column id=\"level\" type=\"STRING\" size=\"256\"/><Column id=\"groupId\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuNm\" type=\"STRING\" size=\"256\"/><Column id=\"menuUrl\" type=\"STRING\" size=\"256\"/><Column id=\"sortNo\" type=\"STRING\" size=\"256\"/><Column id=\"upMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000005</Col><Col id=\"menuNm\">시스템관리</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000006</Col><Col id=\"menuNm\">사용자관리</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000007</Col><Col id=\"menuNm\">공지사항관리</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">공통코드관리</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000008</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">톻계</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000009</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">4</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA00000007</Col><Col id=\"menuNm\">관리</Col><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col><Col id=\"menuUrl\"/></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000008</Col><Col id=\"menuNm\">기업회원</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000009</Col><Col id=\"menuNm\">프로젝트</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000011</Col><Col id=\"menuNm\">샘플</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000012</Col><Col id=\"menuNm\">샘플예제</Col><Col id=\"menuUrl\">sample::common.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000013</Col><Col id=\"menuNm\">crud 예제</Col><Col id=\"menuUrl\">sample::crudtest.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000011</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000014</Col><Col id=\"menuNm\">파일 업로드/다운로드</Col><Col id=\"menuUrl\">sample::file.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000011</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsCop", this);
            obj._setContents("<ColumnInfo><Column id=\"level\" type=\"STRING\" size=\"256\"/><Column id=\"groupId\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuNm\" type=\"STRING\" size=\"256\"/><Column id=\"menuUrl\" type=\"STRING\" size=\"256\"/><Column id=\"sortNo\" type=\"STRING\" size=\"256\"/><Column id=\"upMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000005</Col><Col id=\"menuNm\">개발자</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000006</Col><Col id=\"menuNm\">목록</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA00000007</Col><Col id=\"menuNm\">자료실</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">자유게시판</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000007</Col><Col id=\"menuId\">SA0000009</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000007</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">My Page</Col><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000011</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000012</Col><Col id=\"menuNm\">My Info</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000013</Col><Col id=\"menuNm\">쪽지</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000011</Col><Col id=\"menuId\">SA00000014</Col><Col id=\"menuNm\">지원현황</Col><Col id=\"menuUrl\">pattern::pattern03-file.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000011</Col><Col id=\"useYn\">Y</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsSample", this);
            obj._setContents("<ColumnInfo><Column id=\"level\" type=\"STRING\" size=\"256\"/><Column id=\"groupId\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuNm\" type=\"STRING\" size=\"256\"/><Column id=\"menuUrl\" type=\"STRING\" size=\"256\"/><Column id=\"sortNo\" type=\"STRING\" size=\"256\"/><Column id=\"upMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000005</Col><Col id=\"menuNm\">샘플</Col><Col id=\"menuUrl\"/><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000001</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000012</Col><Col id=\"menuNm\">조회/입력/수정/삭제 예제</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000013</Col><Col id=\"menuNm\">엑셀 처리 예제</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">파일 예제</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000014</Col><Col id=\"menuUrl\">pattern::pattern03-file.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"menuNm\">대용량 분할전송</Col><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000005</Col><Col id=\"menuId\">SA00000015</Col><Col id=\"menuUrl\">pattern::pattern04-file.xfdl</Col><Col id=\"sortNo\">4</Col><Col id=\"upMenuId\">SA00000005</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">0</Col><Col id=\"groupId\">SA00000006</Col><Col id=\"menuId\">SA00000006</Col><Col id=\"menuNm\">추가메뉴2</Col><Col id=\"sortNo\">0</Col><Col id=\"upMenuId\">SA00000006</Col><Col id=\"useYn\">Y</Col><Col id=\"menuUrl\"/></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000006</Col><Col id=\"menuId\">SA0000007</Col><Col id=\"menuNm\">조회/입력/수정/삭제 예제2</Col><Col id=\"menuUrl\">pattern::pattern01-transaction.xfdl</Col><Col id=\"sortNo\">1</Col><Col id=\"upMenuId\">SA00000006</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000006</Col><Col id=\"menuId\">SA0000008</Col><Col id=\"menuNm\">엑셀 처리 예제2</Col><Col id=\"menuUrl\">pattern::pattern02-excel.xfdl</Col><Col id=\"sortNo\">2</Col><Col id=\"upMenuId\">SA00000006</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000006</Col><Col id=\"menuId\">SA0000009</Col><Col id=\"menuNm\">파일 예제2</Col><Col id=\"menuUrl\">pattern::pattern03-file.xfdl</Col><Col id=\"sortNo\">3</Col><Col id=\"upMenuId\">SA00000006</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"level\">1</Col><Col id=\"groupId\">SA00000006</Col><Col id=\"menuId\">SA00000010</Col><Col id=\"menuNm\">대용량 분할전송2</Col><Col id=\"menuUrl\">pattern::pattern04-file.xfdl</Col><Col id=\"sortNo\">4</Col><Col id=\"upMenuId\">SA00000006</Col><Col id=\"useYn\">Y</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds00", this);
            obj._setContents("");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new ImageViewer("img00","0","0","1040","724",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_image("URL(\"theme://images/login.jpg\")");
            this.addChild(obj.name, obj);

            obj = new Div("divLogin","299","301","500","80",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("");
            obj.set_background("");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","128","17","50","20",null,null,null,null,null,null,this.divLogin.form);
            obj.set_taborder("4");
            obj.set_text("ID");
            this.divLogin.addChild(obj.name, obj);

            obj = new Edit("edId","180","17","140","20",null,null,null,null,null,null,this.divLogin.form);
            obj.set_taborder("1");
            this.divLogin.addChild(obj.name, obj);

            obj = new Static("Static01","128","39","50","20",null,null,null,null,null,null,this.divLogin.form);
            obj.set_taborder("0");
            obj.set_text("PW");
            this.divLogin.addChild(obj.name, obj);

            obj = new Edit("edPw","180","39","140","20",null,null,null,null,null,null,this.divLogin.form);
            obj.set_taborder("2");
            this.divLogin.addChild(obj.name, obj);

            obj = new Button("btnLogin","336","14","71","50",null,null,null,null,null,null,this.divLogin.form);
            obj.set_taborder("3");
            obj.set_text("Login");
            this.divLogin.addChild(obj.name, obj);

            obj = new ImageViewer("img01","487","626","151","48",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_image("URL(\"theme://images/kosmo.png\")");
            obj.set_stretch("fit");
            this.addChild(obj.name, obj);

            obj = new Static("sta00","413","190","387","60",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("채용 관리 시스템");
            obj.set_font("italic 48px/normal \"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Button("btnCopReg","556","530","113","32",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("기업회원 가입");
            this.addChild(obj.name, obj);

            obj = new Button("btnReg","682","530","113","32",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("개인회원 가입");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo00","402","444","98","19",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("cbo00");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1040,720,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","divLogin.form.edId","value","dsSearch","id");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","divLogin.form.edPw","value","dsSearch","password");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("frameLogin.xfdl", function() {
        /**
        *  컨설팅 표준화 작업
        *  @MenuPath
        *  @FileName 		frameWork.xfdl
        *  @Creator 			soojeong
        *  @CreateDate 	2017.01.23
        *  @LastModifier
        *  @LastModifyDate
        *  @Version 		1.0
        *  @Outline
        *  @Desction
        ************** 소스 수정 이력 *************************************************
        *    date          		Modifier            Description
        *******************************************************************************
        *  2017.01.23     	soojeong 	           최초 생성
        *******************************************************************************
        */

        /************************************************************************************************
         * FORM 변수 선언 영역
         ************************************************************************************************/

        this.objApp;
        this.objMainframe;
        /***********************************************************************************************
        * FORM EVENT 영역(onload)
        /***********************************************************************************************/
        this.form_onload = function(obj,e)
        {
        	this.objApp = nexacro.getApplication() ;
        	this.objMainframe = this.objApp.mainframe ;

        	this.form_onsize();
        };
        /************************************************************************************************
        * TRANSACTION 서비스 호출 처리
        ************************************************************************************************/

        /************************************************************************************************
         * CALLBACK 콜백 처리부분
         ************************************************************************************************/

         /************************************************************************************************
         * 사용자 FUNCTION 영역
         ************************************************************************************************/
        /**
        * form onsize 변경시
        * @return
        * @example
        * @memberOf public
        */
        this.form_onsize = function()
        {
        	var nLeft = (this.objMainframe.width / 2) - Math.round((this.divLogin.form.getOffsetWidth()) / 2);
        	var nTop = (this.objMainframe.height / 2) - Math.round((this.divLogin.form.getOffsetHeight()) / 2);

        	if(nLeft <= 0)
        	{
        		this.divLogin.form.setOffsetLeft(0);
        	}
        	else
        	{
        		this.divLogin.setOffsetLeft(nLeft);
        		this.divLogin.setOffsetTop(nTop);
        	}

        	this.divLogin.form.edId.setFocus();
        };

        /**
        * fnSetSeprateFrame
        * @return
        * @example
        * @memberOf
        */
        this.fnSetSeprateFrame = function()
        {
        	this.objApp.gvVFrameSet.set_separatesize("44,0,*,20");

        	//gloval variable 회사세팅
        	nexacro.setEnvironmentVariable("gvUserId", this.objApp.gdsUserInfo.getColumn(0,"userId"));
        	nexacro.setEnvironmentVariable("gvUserNm", this.objApp.gdsUserInfo.getColumn(0,"UserNm"));

        	//topframe argument setting
        	this.objApp.gvTopFrame.form.fnLoad();
        	this.objApp.gvTopFrame.form.fnSetName();

        	//this.objApp.gvLeftFrame.form.divLeft.form.grdTree.set_binddataset("gdsMenu");
        	//this.objApp.gvLeftFrame.form.fnSetTreeStatus();

        	//mainform 메인화면 구성 데이터 조회
        	//application.gvWorkFrame.frames["MainForm"].form.fn_selectComposition();
        }
        /************************************************************************************************
         * 각 COMPONENT 별 EVENT 영역
         ************************************************************************************************/
        this.Form_onsize = function(obj,e)
        {
        	this.form_onsize();
        };

        this.divLogin_btnLogin_onclick = function(obj,e)
        {
            //trace(nexacro.getEnvironmentVariable("gvRunMode"));

        	var loginYn = nexacro.getEnvironmentVariable("loginYn");
        	var gvServerUrl = nexacro.getEnvironmentVariable("gvServerUrl");

        	//alert("loginYn : " +  nexacro.getEnvironmentVariable("loginYn")  + " gvServerUrl : " + gvServerUrl);

        	//로컬환경에서 global dataset으로 화면열기
        	//if (nexacro.getEnvironmentVariable("gvRunMode") == "0" || nexacro.getEnvironmentVariable("gvRunMode") == "1")
        	//{

        		//sample화면 메뉴에 추가
        	//	for (var i=0; i< this.dsSample.rowcount; i++)
        	//	{
        	//		var nRow = this.objApp.gdsMenu.addRow();
        	//		this.objApp.gdsMenu.copyRow(nRow, this.dsSample, i);
        	//	}

        	//	this.fnSetSeprateFrame();
        	//}else{
        		//this.fnLogin();	//서버와통신
        	//}

        	if(loginYn == "N") {
        	   this.fnLogin();	//서버와통신
        	}

        	this.objApp.gvLeftFrame.form.fnGlobalMenuCopy();
        };

        /**
         * 로그인 transaction
         * @param {string} reLoginYn
         * @return
         * @example
         *
         * @memberOf
         */
        this.fnLogin = function()
        {
            //var gvServerUrl = nexacro.getEnvironmentVariable("gvServerUrl");
        	var strSvcId    = "login";
        	var strSvcUrl   = "login.do";
        	var inData      = "dsSearch=dsSearch";
        	var outData     = "dsList=dsList";
        	var strArg      = "";
        	var callBackFnc = "fnCallback";

        	//alert("edId : " + this.dsSearch.getColumn("USER_ID") + " edPw : " + this.dsSearch.getColumn("USER_PASSWORD"));
        	//alert(this.dsSearch.saveXML());

        	//생략가능
        	var isAsync   = true;
        	var nDataType = 0;

        	this.gfnTransaction( strSvcId , 	// transaction을 구분하기 위한 svc id값
        								strSvcUrl , 	// trabsaction을 요청할 주소
        								inData , 		// 입력값으로 보낼 dataset id , a=b형태로 실제이름과 입력이름을 매칭
        								outData , 		// 처리결과값으로 받을 dataset id, a=b형태로 실제이름과 입력이름을 매칭
        								strArg, 			// 입력갑스로 보낼 arguments, strFormData="20120607"
        								callBackFnc, 	// transaction의 결과를 받을 Function 이름
        								nDataType); // 통신방법 정의 [생략가능]


        }

        /**************************************************************************************************
        * CallBack Function (서버수신)
        ***************************************************************************************************/
        this.fnCallback = function(svcID,errorCode,errorMsg)
        {
        	switch(svcID)
        	{
        		case "login":

        		    //alert(this.dsList.saveXML() );

        			if( !this.gfnIsNull(this.dsList.getColumn(0,"userName"))  ){
        				var usertype = this.dsList.getColumn(0, "usertype");

        			    //sample화면 메뉴에 추가
        				if(usertype == "A") {
        					for (var i=0; i< this.dsAdmin.rowcount; i++)
        					{
        						var nRow = this.objApp.gdsMenu.addRow();
        						this.objApp.gdsMenu.copyRow(nRow, this.dsAdmin, i);
        					}
                        }

        				if(usertype == "C") {
        					for (var i=0; i< this.dsCop.rowcount; i++)
        					{
        						var nRow = this.objApp.gdsMenu.addRow();
        						this.objApp.gdsMenu.copyRow(nRow, this.dsCop, i);
        					}
                        }

        				if(usertype == "D") {
        					for (var i=0; i< this.dsMember.rowcount; i++)
        					{
        						var nRow = this.objApp.gdsMenu.addRow();
        						this.objApp.gdsMenu.copyRow(nRow, this.dsMember, i);
        					}
                        }

        				this.objApp.gdsUserInfo.setColumn(0,"userId", this.dsList.getColumn(0,"id"));
        				this.objApp.gdsUserInfo.setColumn(0,"UserNm", this.dsList.getColumn(0,"userName"));

        				nexacro.setEnvironmentVariable("gvUserId",this.dsList.getColumn(0,"id"));
        				nexacro.setEnvironmentVariable("gvUserNm",this.dsList.getColumn(0,"userName"));
        				nexacro.setEnvironmentVariable("gvUserType",this.dsList.getColumn(0,"usertype"));
        			    nexacro.setEnvironmentVariable("loginYn","Y");

        				//alert("login callabck gvUserId 1 : " +  this.objApp.gdsUserInfo.getColumn(0,"userId")  + "  UserNm : " +  this.objApp.gdsUserInfo.getColumn(0,"UserNm"));
        				//alert("login callabck gvUserId 2 : " +  nexacro.getEnvironmentVariable("gvUserId")  + "userName : " +  nexacro.getEnvironmentVariable("gvUserNm"));

        			    this.fnSetSeprateFrame();
        	            this.objApp.gvLeftFrame.form.fnGlobalMenuCopy();

        			    return;
        			}

        			alert("로그인에 실패하였습니다. ");
        			break;

        // 		case "save":
        // 			this.fnSearch();//재조회
        // 			break;
        	}
        };
        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.form_onload,this);
            this.addEventHandler("onsize",this.Form_onsize,this);
            this.divLogin.form.btnLogin.addEventHandler("onclick",this.divLogin_btnLogin_onclick,this);
            this.img01.addEventHandler("onclick",this.img00_onclick,this);
        };

        this.loadIncludeScript("frameLogin.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
