
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="dist_home/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">AdminLTE 3</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist_home/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a id="usernameDisplay" href="#" class="d-block"></a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav  class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          
			<li class="nav-item">
            <a id="dashboardLink" href="gradeRstWaitingList.html" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a id="gradeLink" href="gradeRstWaitingList.html" class="nav-link">
              <i class="nav-icon far fa-calendar-alt"></i>
              <p>
                Grade Results
                <span class="badge badge-info right">2</span>
              </p>
            </a>
          </li>
          
          <li class="nav-item">
            <a id="manageLink" href="manageQuestion.html" class="nav-link">
               <i class="nav-icon fas fa-edit"></i>
              <p>
                Manage Questions
              </p>
            </a>
          </li>
          <li id="btn-managequestion" class="nav-item">
            <a id="addLink" href="addQuestion.html" class="nav-link">
               <i class="nav-icon fas fa-copy"></i>
              <p >
                Add Question
              </p>
            </a>
          </li>
           <li class="nav-item">
            <a id="logoutLink" href="logout.html" class="nav-link">
               <i class="nav-icon fas fa-door-open"></i>
              <p>
                Logout
              </p>
            </a>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  