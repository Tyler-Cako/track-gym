package com.tylercako.track531.model.db

import com.tylercako.track531.model.db.enum.ExerciseTypes
import java.util.Date

data class Exercise(
    val id: Int,
    val exerciseType: ExerciseTypes,
    val oneRepMax: Float,
    val split1: Split,
    val isSplit1Completed: Boolean,
    val split2: Split,
    val isSplit2Completed: Boolean,
    val split3: Split,
    val isSplit3Completed: Boolean,
    val date: Date
)