package com.gudi.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CkeditorFileUploadController {

	@RequestMapping(value = "ckUpload", method = RequestMethod.POST)
	@ResponseBody
	public void ckUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload,
			HttpSession session) throws Exception {
		// logger.info("ckUpload 진입 =========================================1");
		// 랜덤 문자 생성
		//UUID 클래스의 randomUUID() 메소드를 사용해서 유일한 식별자를 생성합니다.
		UUID uid = UUID.randomUUID();
		OutputStream out = null;
		PrintWriter printWriter = null;
		// 인코딩
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		try {
			String fileName = upload.getOriginalFilename();
			// 파일 이름 가져오기
			byte[] bytes = upload.getBytes();
			// 업로드 경로 확인  File.separator = 경로를 구분하기 위해 사용
			String uploadPath = session.getServletContext().getRealPath("/") + "resources" + File.separator + "upload"
					+ File.separator;
			String ckUploadPath = uploadPath + uid + "_" + fileName;

			out = new FileOutputStream(new File(ckUploadPath));

			out.write(bytes);
			out.flush();

			// out에 저장된 데이터를 전송하고 초기화
			// String callback = req.getParameter("CKEditorFuncNum");
			printWriter = res.getWriter();//텍스트 출력 스트림
			String fileUrl = req.getContextPath() + "/resources/upload/" + uid + "_" + fileName;

			printWriter.println("{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		return;

	}

}