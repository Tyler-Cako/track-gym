package com.tylercako.track531.model

import com.tylercako.track531.model.db.Exercise
import com.tylercako.track531.model.db.User

data class UserExercise(val user: User, val exercise: Exercise) {}