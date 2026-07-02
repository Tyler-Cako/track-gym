package com.tylercako.track531.repository

import com.tylercako.track531.model.db.Exercise

interface ExerciseRepository {
    fun findById(id: String): Exercise?;
    fun findByUserId(userId: String): List<Exercise>;
}