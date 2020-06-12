<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cts.ind.DictionaryManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>CTS Assessment</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.12.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/index.css" rel="stylesheet" />
    </head>
    
    <%
    DictionaryManager dictionaryManager = new DictionaryManager();
    String strLang="ENG";
    if ("BM".equals(request.getParameter("language"))){
    	strLang="BM";
    }
   
    %>
    <script>
    function changeLang(lang){
    	document.getElementById("language").value=lang;
    	document.getElementById('langForm').submit(); 
	   }
    </script>
    
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="assets/img/navbar-logo.svg" /></a><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services"><%=dictionaryManager.getTerm("index.services.title",strLang) %></a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio"><%=dictionaryManager.getTerm("index.constructs.title",strLang) %></a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about"><%=dictionaryManager.getTerm("index.nav.importance",strLang) %></a></li>
<%--                         <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact"><%=dictionaryManager.getTerm("index.nav.contact",strLang) %></a></li>
 --%>                        <li class="nav-item"><a class="nav-link portfolio-link" data-toggle="modal" href="#registerModal">Register / Login</a></li>
                        <li class="nav-item">
                        	<div class="dropdown">
							  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="global" src="assets/img/index/global-icon-lang.png" /> <%=strLang %></button>
							  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							    <button  onclick="changeLang('ENG')" class="dropdown-item" href="#">English</button>
							    <button  onclick="changeLang('BM')" class="dropdown-item" href="#">Bahasa Melayu</button>
							  </div>
							  <form id="langForm" method="get" action="/FirstForm/CTS"><input type="hidden" name="language" id="language"></form>
							</div> 
						</li>
                    </ul>
                </div>
            </div>
        </nav>

        <header class="masthead">
            <div class="container">
                 <div class="masthead-subheading"><%=dictionaryManager.getTerm("index.main.cts.subtitle",strLang) %></div>
                 <div class="masthead-heading text-uppercase"><%=dictionaryManager.getTerm("index.main.cts.title",strLang) %></div>
                <a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" href="#services"><%=dictionaryManager.getTerm("index.main.cts.tellmemore",strLang) %></a>
            </div>
        </header>
        <!-- Services-->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.services.title",strLang) %></h2>
                    <h3 class="section-subheading text-muted"><%=dictionaryManager.getTerm("index.services.title.dscp",strLang) %></h3>
                </div>
                <div class="row text-center">
                    <div class="col-md-4">
                        <span class="fa-stack fa-4x"><i class="fas fa-circle fa-stack-2x text-primary"></i><i class="fas fa-digital-tachograph fa-stack-1x fa-inverse"></i></span>
                        <h4 class="my-3"><%=dictionaryManager.getTerm("index.services.learning",strLang) %></h4>
                        <p class="text-muted"><%=dictionaryManager.getTerm("index.services.learning.dscp",strLang) %></p>
                    </div>
                    <div class="col-md-4">
                        <span class="fa-stack fa-4x"><i class="fas fa-circle fa-stack-2x text-primary"></i><i class="fas fa-chalkboard-teacher fa-stack-1x fa-inverse"></i></span>
                        <h4 class="my-3"><%=dictionaryManager.getTerm("index.services.teaching",strLang) %></h4>
                        <p class="text-muted"><%=dictionaryManager.getTerm("index.services.teaching.dscp",strLang) %></p>
                    </div>
                    
                </div>
            </div>
        </section>
        <!-- Assessment Constructs-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.constructs.title",strLang) %></h2>
                    <h3 class="section-subheading text-muted"><%=dictionaryManager.getTerm("index.constructs.title.dscp",strLang) %></h3>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal1"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/analysis.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.ana.title",strLang) %></div>
                             <!--    <div class="portfolio-caption-subheading text-muted">Illustration</div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal2"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/sudoku.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.log.title",strLang) %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal3"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/judgement.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.judgement.title",strLang) %></div>
                            </div>
                        </div>
                    </div>
                   
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal4"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/solution.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.probsolve.title",strLang) %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-sm-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal5"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/explore.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.creative.title",strLang) %></div>
                            </div>
                        </div>
                    </div>
                   
            </div>
        </section>
        <!-- About-->
        <section class="page-section" id="about">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.importance.title",strLang) %></h2>
                    <h3 class="section-subheading text-muted"><%=dictionaryManager.getTerm("index.importance.subtitle",strLang) %></h3>
                </div>
                <ul class="timeline">
                
                     <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/child.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                            <h6><%=dictionaryManager.getTerm("index.importance.constructivism.subtitle",strLang) %></h6>
                                 <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.constructivism",strLang) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.constructivism.dscp",strLang) %>
                            </p></div>
                        </div>
                    </li>
                    
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/exam.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                               <h6><%=dictionaryManager.getTerm("index.importance.academic.subtitle",strLang) %></h6>
                               <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.academic",strLang) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.academic.dscp",strLang) %>
                            </p></div>
                        </div>
                    </li>
                    
                    <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/grow.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                            <h6><%=dictionaryManager.getTerm("index.importance.maturity.subtitle",strLang) %></h6>
                                <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.maturity",strLang) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.maturity.dscp",strLang) %>
                            </p></div>
                        </div>
                    </li>
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/goal.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h6><%=dictionaryManager.getTerm("index.importance.personalities.subtitle",strLang) %></h6> 
                                <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.personalities",strLang) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.personalities.dscp",strLang) %>
                            </p></div>
                        </div>
                    </li>
                    
                </ul>
            </div>
        </section>
        
        <%-- 
        <!-- Team-->
        <section class="page-section bg-light" id="team">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.team.title",strLang) %></h2>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="team-member">
                            <img class="mx-auto rounded-circle" src="assets/img/team/1.jpg" alt="" />
                            <h4>Dr. Ow Siew Hock</h4>
                            <p class="text-muted"><%=dictionaryManager.getTerm("index.team.supervisor",strLang) %></p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="team-member">
                            <img class="mx-auto rounded-circle" src="assets/img/team/2.jpg" alt="" />
                            <h4>Wong Vee Yuan</h4>
                            <p class="text-muted"><%=dictionaryManager.getTerm("index.team.developer",strLang) %></p>
<!--                             <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-twitter"></i></a><a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a><a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-linkedin-in"></i></a>
 -->                        </div>
                    </div>
                    
                </div>
               
            </div>
        </section>
        --%>
        
        <!-- Contact-->
        <section class="page-section" id="contact">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.contact.title",strLang) %></h2>
                    <h3 class="section-subheading text-muted"><%=dictionaryManager.getTerm("index.contact.subtitle",strLang) %></h3>
                </div>
                <form id="contactForm" name="sentMessage" novalidate="novalidate">
                    <div class="row align-items-stretch mb-5">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="form-control" id="name" type="text" placeholder="<%=dictionaryManager.getTerm("index.contact.name",strLang) %>" required="required" data-validation-required-message="Please enter your name." />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="form-group">
                                <input class="form-control" id="email" type="email" placeholder="<%=dictionaryManager.getTerm("index.contact.email",strLang) %>" required="required" data-validation-required-message="Please enter your email address." />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="form-group mb-md-0">
                                <input class="form-control" id="phone" type="tel" placeholder="<%=dictionaryManager.getTerm("index.contact.phone",strLang) %>" required="required" data-validation-required-message="Please enter your phone number." />
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group form-group-textarea mb-md-0">
                                <textarea class="form-control" id="message" placeholder="<%=dictionaryManager.getTerm("index.contact.message",strLang) %>" required="required" data-validation-required-message="Please enter a message."></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <div id="success"></div>
                        <button class="btn btn-primary btn-xl text-uppercase" id="sendMessageButton" type="submit"><%=dictionaryManager.getTerm("index.contact.btn.send",strLang) %></button>
                    </div>
                </form>
            </div>
        </section>
        <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-left">Copyright Reserved 2020</div>
                    <div class="col-lg-4 my-3 my-lg-0">
                        <a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-twitter"></i></a><a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a><a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-linkedin-in"></i></a>
                    </div>
<!--                     <div class="col-lg-4 text-lg-right"><a class="mr-3" href="#!">Privacy Policy</a><a href="#!">Terms of Use</a></div>
 -->                </div>
            </div>
        </footer>
        
        
        
        
        
   <!-- Portfolio Modals--><!-- Modal 1-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.ana.title",strLang) %></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.ana.subtitle",strLang) %></p>
                                    <p> <%=dictionaryManager.getTerm("index.constructs.ana.dscp",strLang) %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
   <!-- Portfolio Modals--><!-- Modal 2-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.log.title",strLang)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.log.subtitle",strLang) %></p>
                                    <p> <%=dictionaryManager.getTerm("index.constructs.log.dscp",strLang) %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>   
        
  <!-- Portfolio Modals--><!-- Modal 3-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.judgement.title",strLang)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.judgement.subtitle",strLang) %></p>
                                    <p> <%=dictionaryManager.getTerm("index.constructs.judgement.dscp",strLang) %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
   
   <!-- Portfolio Modals--><!-- Modal 4-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.probsolve.title",strLang)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.probsolve.subtitle",strLang) %></p>
                                    <p> <%=dictionaryManager.getTerm("index.constructs.probsolve.dscp",strLang) %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
        
    <!-- Portfolio Modals--><!-- Modal 5-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container" >
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body" >
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.creative.title",strLang)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.creative.subtitle",strLang) %></p>
                                    <p> <%=dictionaryManager.getTerm("index.constructs.creative.dscp",strLang) %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
        
            <!-- Register-->
        <div class="portfolio-modal modal fade" id="registerModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="padding-top:40px;">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                       <jsp:include page="/WEB-INF/jsp/register.jsp" />   
               </div>
            </div>
        </div>  
        
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
    </body>
</html>