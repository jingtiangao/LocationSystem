package com.grain.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import com.grain.Template;
import com.grain.dao.ArticleDao;
import com.grain.entity.Article;
import com.grain.service.StaticService;
import com.grain.service.TemplateService;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * Service - 静态化
 * 
 */
@Service("staticServiceImpl")
public class StaticServiceImpl implements StaticService, ServletContextAware {

	/** Sitemap最大地址数 */
	//private static final Integer SITEMAP_MAX_SIZE = 40000;

	/** servletContext */
	private ServletContext servletContext;

	@Resource(name = "freeMarkerConfigurer")
	private FreeMarkerConfigurer freeMarkerConfigurer;
	@Resource(name = "templateServiceImpl")
	private TemplateService templateService;
	@Resource(name = "articleDaoImpl")
	private ArticleDao articleDao;

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Transactional(readOnly = true)
	public int build(String templatePath, String staticPath, Map<String, Object> model) {
		Assert.hasText(templatePath);
		Assert.hasText(staticPath);

		FileOutputStream fileOutputStream = null;
		OutputStreamWriter outputStreamWriter = null;
		Writer writer = null;
		try {
			freemarker.template.Template template = freeMarkerConfigurer.getConfiguration().getTemplate(templatePath);
			File staticFile = new File(servletContext.getRealPath(staticPath));
			File staticDirectory = staticFile.getParentFile();
			if (!staticDirectory.exists()) {
				staticDirectory.mkdirs();
			}
			fileOutputStream = new FileOutputStream(staticFile);
			outputStreamWriter = new OutputStreamWriter(fileOutputStream, "UTF-8");
			writer = new BufferedWriter(outputStreamWriter);
			template.process(model, writer);
			writer.flush();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(writer);
			IOUtils.closeQuietly(outputStreamWriter);
			IOUtils.closeQuietly(fileOutputStream);
		}
		return 0;
	}

	@Transactional(readOnly = true)
	public int build(String templatePath, String staticPath) {
		return build(templatePath, staticPath, null);
	}

	@Transactional(readOnly = true)
	public int build(Article article) {
		Assert.notNull(article);

		delete(article);
		Template template = templateService.get("articleContent");
		int buildCount = 0;
		if (article.getIsPublication()) {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("article", article);
			for (int pageNumber = 1; pageNumber <= article.getTotalPages(); pageNumber++) {
				article.setPageNumber(pageNumber);
				buildCount += build(template.getTemplatePath(), article.getPath(), model);
			}
			article.setPageNumber(null);
		}
		return buildCount;
	}

	@Transactional(readOnly = true)
	public int buildIndex() {
		Template template = templateService.get("index");
		return build(template.getTemplatePath(), template.getStaticPath());
	}

	@Transactional(readOnly = true)
	public int buildSitemap() {
		int buildCount = 0;
/*		Template sitemapIndexTemplate = templateService.get("sitemapIndex");
		Template sitemapTemplate = templateService.get("sitemap");
		Map<String, Object> model = new HashMap<String, Object>();
		List<String> staticPaths = new ArrayList<String>();
		for (int step = 0, index = 0, first = 0, count = SITEMAP_MAX_SIZE;;) {
			try {
				model.put("index", index);
				String templatePath = sitemapTemplate.getTemplatePath();
				String staticPath = FreemarkerUtils.process(sitemapTemplate.getStaticPath(), model);
				if (step == 0) {
					List<Article> articles = articleDao.findList(first, count, null, null);
					model.put("articles", articles);
					if (articles.size() < count) {
						step++;
						first = 0;
						count -= articles.size();
					} else {
						buildCount += build(templatePath, staticPath, model);
						articleDao.clear();
						articleDao.flush();
						staticPaths.add(staticPath);
						model.clear();
						index++;
						first += articles.size();
						count = SITEMAP_MAX_SIZE;
					}
				} 
				
				buildCount += build(sitemapIndexTemplate.getTemplatePath(), sitemapIndexTemplate.getStaticPath(), model);
				break;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}*/
		return buildCount;
	}

	@Transactional(readOnly = true)
	public int buildOther() {
		int buildCount = 0;
/*		Template shopCommonJsTemplate = templateService.get("shopCommonJs");
		Template adminCommonJsTemplate = templateService.get("adminCommonJs");
		buildCount += build(shopCommonJsTemplate.getTemplatePath(), shopCommonJsTemplate.getStaticPath());
		buildCount += build(adminCommonJsTemplate.getTemplatePath(), adminCommonJsTemplate.getStaticPath());
*/		return buildCount;
	}

	@Transactional(readOnly = true)
	public int buildAll() {
		int buildCount = 0;
		for (int i = 0; i < articleDao.count(); i += 20) {
			List<Article> articles = articleDao.findList(i, 20, null, null);
			for (Article article : articles) {
				buildCount += build(article);
			}
			articleDao.clear();
		}
		buildIndex();
		buildSitemap();
		buildOther();
		return buildCount;
	}

	@Transactional(readOnly = true)
	public int delete(String staticPath) {
		Assert.hasText(staticPath);

		File staticFile = new File(servletContext.getRealPath(staticPath));
		if (staticFile.exists()) {
			staticFile.delete();
			return 1;
		}
		return 0;
	}

	@Transactional(readOnly = true)
	public int delete(Article article) {
		Assert.notNull(article);

		int deleteCount = 0;
		for (int pageNumber = 1; pageNumber <= article.getTotalPages() + 1000; pageNumber++) {
			article.setPageNumber(pageNumber);
			int count = delete(article.getPath());
			if (count < 1) {
				break;
			}
			deleteCount += count;
		}
		article.setPageNumber(null);
		return deleteCount;
	}


	@Transactional(readOnly = true)
	public int deleteIndex() {
		Template template = templateService.get("index");
		return delete(template.getStaticPath());
	}

	@Transactional(readOnly = true)
	public int deleteOther() {
		int deleteCount = 0;
		Template shopCommonJsTemplate = templateService.get("shopCommonJs");
		Template adminCommonJsTemplate = templateService.get("adminCommonJs");
		deleteCount += delete(shopCommonJsTemplate.getStaticPath());
		deleteCount += delete(adminCommonJsTemplate.getStaticPath());
		return deleteCount;
	}

	@Override
	public int buildCatalogindexMenu() {
		Template template = templateService.get("catalogindexlistmenu");
		return build(template.getTemplatePath(), template.getStaticPath());
	}

}