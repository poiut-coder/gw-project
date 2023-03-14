<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>home</title>

    <!-- meta -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- css -->
    <jsp:include page="/WEB-INF/views/modules/home-css.jsp" />
    <!-- fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic|Roboto+Condensed:300italic,400italic,700italic,400,300,700|Oxygen:400,300,700' rel='stylesheet'>
    <script src="https://kit.fontawesome.com/59c4b897d3.js" crossorigin="anonymous"></script>
</head>

<body id="home">
<!-- ****************************** Sidebar ************************** -->

<nav id="sidebar-wrapper" class="active">
    <a id="menu-close" href="#" class="close-btn toggle"><i class="ion-ios-close-empty"></i></a>
    <ul class="sidebar-nav">
        <li><a href="#home">Home</a></li>
        <li><a href="#gallery">Gallery</a></li>
        <li><a href="aboutus.action">About us</a></li>
        <li><a href="/gw-project/member/register">Registration</a></li>
        <li><a href="member/login">LogIn</a></li>
    </ul>
</nav>

<!-- ****************************** Header ************************** -->

<header class="sticky" id="header" >
    <section class="container">
        <section class="row" id="logo_menu">
            <section class="col-xs-8"><a class="logo" href="">Green Office</a></section>
            <section class="col-xs-4"><a id="menu-toggle" href="#" class="toggle wow rotateIn" data-wow-delay="1s"><i class="ion-navicon"></i></a></section>
        </section>
    </section>
</header>

<!-- ****************************** Banner ************************** -->


<section id="banner">
    <section class="container">
        <a class="slidedown wow animated zoomIn" data-wow-delay="2s" href="#features"><i class="ion-ios-download-outline"></i></a>
        <section class="row" >
            <div class="col-md-6">
                <div class="headings">
                    <h1 class="wow animated fadeInDown">그린과 함께라면</h1>
                    <p class="wow animated fadeInLeft"><h3>우리 회사 업무에 필요한 모든 것<br>그린오피스 하나면 끝</h3></p>
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-5">
                            <div>
                                <a href="#" class="polo-btn store wow animated bounceInUp"><i class="ion-social-android"></i> Play Store</a>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-5">
                            <div>
                                <a href="#" class="polo-btn store wow animated bounceInUp"><i class="ion-social-apple"></i> App Store</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 hidden-xs hidden-sm">
                <div class="hand-container">
                    <img class="iphone-hand img_res wow animated bounceInUp" data-wow-duration="1.2s" src="/gw-project/resources/dist/img/iphone_hand.png" alt="">
                </div>
                <div class="clearfix"></div>
            </div>
            </div>
        </section>
    </section>
</section>
</section>

<!-- ****************************** Features Section ************************** -->

<%--<section id="features" class="block">--%>
<%--    <section class="container">--%>
<%--        <section class="row">--%>
<%--            <div class="title-box"><h1 class="block-title wow animated rollIn">--%>
<%--                <span class="bb-top-left"></span>--%>
<%--                <span class="bb-bottom-left"></span>--%>
<%--                Features--%>
<%--                <span class="bb-top-right"></span>--%>
<%--                <span class="bb-bottom-right"></span>--%>
<%--            </h1></div>--%>
<%--        </section>--%>

<%--        <section class="row">--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.3s">--%>
<%--                    <i class="ion-ios-settings" style="color:#9b59b6;"></i>--%>
<%--                    <h2>Tune up</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.3s">--%>
<%--                    <i class="ion-ios-locked-outline" style="color:#d35400;"></i>--%>
<%--                    <h2>Security</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.3s">--%>
<%--                    <i class="ion-nuclear" style="color:#00ceb8;"></i>--%>
<%--                    <h2>Firewall</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.6s">--%>
<%--                    <i class="ion-ios-browsers-outline" style="color:#c0392b;"></i>--%>
<%--                    <h2>HD Widgets</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.6s">--%>
<%--                    <i class="ion-ios-loop" style="color:#27ae60;"></i>--%>
<%--                    <h2>Data Sync</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-sm-6 col-md-4">--%>
<%--                <div class="feature-box wow animated flipInX" data-wow-delay="0.6s">--%>
<%--                    <i class="ion-ios-glasses" style="color:#2c3e50;"></i>--%>
<%--                    <h2>Customize</h2>--%>
<%--                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </section>--%>
<%--        <div class="clearfix"></div>--%>
<%--    </section>--%>
<%--</section>--%>

<!-- ****************************** Team Section ************************** -->

<section id="team" class="block">
    <section class="container">
        <section class="row">
            <div class="col-md-12">
                <div class="title-box">
                    <h1 class="block-title wow animated rollIn">
                        <span class="bb-top-left"></span>
                        <span class="bb-bottom-left"></span>
                        GREEN OFFICE TEAM
                        <span class="bb-top-right"></span>
                        <span class="bb-bottom-right"></span>
                    </h1>
                </div>
            </div>
        </section>
        <section class="row">
        <table style="margin: auto;">
            <tr>
                  <td style="padding: 20px;">
                      <section>
                          <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                              <img src="/gw-project/resources/dist/img/w1.png" class="img_res team-pic">
                              <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">강수림</h2>
                              <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">회원가입, 로그인, 인사담당 구현</h4>
                              <ul class="team-social">
                                  <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                  <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                  <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                  <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                              </ul>
                          </div>
                      </section>
                  </td>
                <td style="padding: 20px;">
                      <section>
                          <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                              <img src="/gw-project/resources/dist/img/m1.png" class="img_res team-pic">
                              <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">김기주</h2>
                              <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">달력 및 개인 일정 구현</h4>
                              <ul class="team-social">
                                  <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                  <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                  <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                  <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                              </ul>
                          </div>
                      </section>
                </td>
                <td style="padding: 20px;">
                      <section>
                          <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                              <img src="/gw-project/resources/dist/img/m2.png" class="img_res team-pic">
                              <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">김찬연</h2>
                              <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">전자결재 및 조직도 구현</h4>
                              <ul class="team-social">
                                  <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                  <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                  <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                  <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                              </ul>
                          </div>
                      </sectioN>
                  </td>
            </tr>
            <tr>
                <td style="padding: 20px;">
                    <section>
                        <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                            <img src="/gw-project/resources/dist/img/w2.png" class="img_res team-pic">
                            <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">이하영</h2>
                            <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">회사 내 메일함 구현</h4>
                            <ul class="team-social">
                                <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                            </ul>
                        </div>
                    </section>
                </td>
                <td style="padding: 20px;">
                    <section>
                        <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                            <img src="/gw-project/resources/dist/img/m3.png" class="img_res team-pic">
                            <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">한도희</h2>
                            <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">팀별 프로젝트 구현</h4>
                            <ul class="team-social">
                                <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                            </ul>
                        </div>
                    </section>
                </td>
                <td style="padding: 20px;">
                    <section>
                        <div class="team-member wow animated fadeIn" data-wow-delay=="0.3s">
                            <img src="/gw-project/resources/dist/img/w3.png" class="img_res team-pic">
                            <h2 class="wow animated fadeInDown" data-wow-delay=="0.7s">한지해</h2>
                            <h4 class="wow animated fadeIn" data-wow-delay=="0.7s">사내 공지사항 및 익명게시판 구현, 관리자 페이지와 연동</h4>
                            <ul class="team-social">
                                <li class="wow animated fadeInLeft facebook"><a href="#"><i class="ion-social-facebook"></i></a></li>
                                <li class="wow animated fadeInLeft linkedin"><a href="#"><i class="ion-social-linkedin"></i></a></li>
                                <li class="wow animated fadeInRight googleplus"><a href="#"><i class="ion-social-googleplus-outline"></i></a></li>
                                <li class="wow animated fadeInRight github"><a href="#"><i class="ion-social-github"></i></a></li>
                            </ul>
                        </div>
                    </section>
                </td>
            </tr>
        </table>
        </section>
    </section>
</section>

<!-- ****************************** Testimonial ************************** -->

<!-- ****************************** Subscribe Section ************************** -->

<


<section id="footer">
    <section class="container">
        <section class="row">
            <div class="col-sm-6">
                <span>Theme By</span>
                <h1 class="footer-logo">
                    <a href="https://themewagon.com/">그룹웨어</a>
                </h1>
            </div>
            <div class="col-sm-6">
                <p class="copyright">1조 강수림 김기주 김찬연 이하영 한도희 한지해</p>
            </div>
        </section>
    </section>
</section>


<!-- All the scripts -->



</div><!-- /.container-fluid -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- footer -->
<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<!-- /.footer -->

<!-- Control Sidebar -->
<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
<!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->



<jsp:include page="/WEB-INF/views/modules/home-js.jsp" />
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />

<
<script type="text/javascript">



</script>


</body>
</html>