YJ.UsersRoute = Ember.Route.extend(
  route: '/users'
  toDashboard: ((router, event) ->
   router.transitionTo('dashboard')
  )

  dashboard: Ember.Route.extend(
    route: '/'

    connectOutlets: (router) ->
      console.log("i'm in your dashboard outlets")
      router.get('applicationController').connectOutlet('dashboard', YJ.get('currentUser'))
  )

  registration: Ember.Route.extend(
    route: '/register'
    #EVENTS

    createUser: ((router, event) ->
      if router.get('registrationController').register()
        console.log('successfully created a user')
        router.send('toDashboard')
      else
        console.log('failure to create user')
        router.send('toRegister')
    )

    connectOutlets: (router) ->
      appController = router.get('applicationController')
      appController.connectOutlet('registration')
  )

  authentication: Ember.Route.extend(
    route: '/login'
    #EVENTS
    authenticate: ((router, event) ->
      if router.get('loginController').authenticate()
        console.log('successfully logged in')
        router.send('toDashboard')
      else
        console.log('failure to log in')
        router.send('toLogin')

    )

    connectOutlets: (router) ->
      appController = router.get('applicationController')
      appController.connectOutlet('login')
  )

  edit: Ember.Route.extend(
    route: '/edit'
    #EVENTS
    update: ((router, event) ->
      router.get('userController').get('transaction').commit()
      router.send('goHome')
    )

    connectOutlets: (router, context) ->
      appController = router.get('applicationController')
      userController = router.get('userController')
      appController.connectOutlet(
        viewClass: YJ.EditUserView,
        controller: userController,
        context: YJ.currentUser
      )
  )
)